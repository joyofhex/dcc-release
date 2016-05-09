package org.icgc.dcc.release.job.index.core;

import static com.google.common.base.Preconditions.checkState;
import static com.google.common.collect.ImmutableSet.copyOf;
import static com.google.common.collect.Sets.difference;
import static org.icgc.dcc.common.core.util.stream.Collectors.toImmutableList;
import static org.icgc.dcc.common.core.util.stream.Collectors.toImmutableSet;
import static org.icgc.dcc.release.core.document.DocumentType.DONOR_CENTRIC_TYPE;
import static org.icgc.dcc.release.job.index.factory.TransportClientFactory.newTransportClient;
import static org.icgc.dcc.release.job.index.utils.IndexTasks.getIndexName;

import java.util.Collection;
import java.util.Collections;
import java.util.Set;

import lombok.Cleanup;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import lombok.val;
import lombok.extern.slf4j.Slf4j;

import org.icgc.dcc.release.core.document.DocumentType;
import org.icgc.dcc.release.core.job.GenericJob;
import org.icgc.dcc.release.core.job.JobContext;
import org.icgc.dcc.release.core.job.JobType;
import org.icgc.dcc.release.core.task.DeleteFileTask;
import org.icgc.dcc.release.core.task.Task;
import org.icgc.dcc.release.job.index.config.IndexProperties;
import org.icgc.dcc.release.job.index.service.IndexService;
import org.icgc.dcc.release.job.index.service.IndexVerificationService;
import org.icgc.dcc.release.job.index.task.IndexBigFilesTask;
import org.icgc.dcc.release.job.index.task.IndexTask;
import org.icgc.dcc.release.job.index.utils.IndexTasks;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.common.collect.ImmutableSet;

@Slf4j
@Component
@RequiredArgsConstructor(onConstructor = @__({ @Autowired }))
public class IndexJob extends GenericJob {

  /**
   * Dependencies.
   */
  @NonNull
  private final IndexProperties properties;

  @Override
  public JobType getType() {
    return JobType.INDEX;
  }

  @Override
  public void execute(JobContext jobContext) {
    if (properties.isBigDocumentsOnly() == false) {
      clean(jobContext);
    } else {
      log.info("Indexing big documents only. Skipping the cleanup task...");
    }

    // TODO: Fix this to be tied to a run id:
    val indexName = getIndexName(jobContext.getReleaseName());

    //
    // TODO: Need to use spark.dynamicAllocation.enabled to dynamically
    // increase memory for this job
    //
    // -
    // http://spark.apache.org/docs/1.2.0/job-scheduling.html#dynamic-resource-allocation
    // - https://issues.apache.org/jira/browse/SPARK-4751
    //

    @Cleanup
    val client = newTransportClient(properties.getEsUri());
    @Cleanup
    val indexService = new IndexService(client);
    val indexTypes = getIndexTypes();

    // Prepare
    log.info("Initializing index...");
    if (isIndexAll()) {
      indexService.initializeIndex(indexName, indexTypes);
    } else {
      log.info("Unfreezing index because of indexing of big documents only...");
      indexService.unfreezeIndex(indexName);
    }
    indexService.optimizeForIndexing(indexName);

    // Populate
    log.info("Populating index...");
    if (properties.isBigDocumentsOnly() == false) {
      index(jobContext, indexName, indexTypes);
    } else {
      log.info("Indexing big documents only. Skipping the other types...");
    }

    log.info("Indexing big files...");
    indexBigFiles(jobContext);

    // Report
    log.info("Reporting index...");
    indexService.reportIndex(indexName);

    // Compact
    log.info("Optimizing index...");
    indexService.optimizeIndex(indexName);
    indexService.optimizeForSearching(indexName);

    // Freeze
    log.info("Freezing index...");
    indexService.freezeIndex(indexName);

    log.info("Verifying index...");
    val verificationService = new IndexVerificationService(client, indexName);
    verificationService.verify();
  }

  private void clean(JobContext jobContext) {
    val bigDocsPath = IndexTasks.getBigFilesPath(jobContext.getWorkingDir());
    jobContext.execute(new DeleteFileTask(bigDocsPath));
  }

  private boolean isIndexAll() {
    return properties.isBigDocumentsOnly() == false;
  }

  private void index(JobContext jobContext, String indexName, Set<DocumentType> indexTypes) {
    // TODO: https://github.com/icgc-dcc/dcc-release/pull/47#discussion_r61414413
    jobContext.execute(createIndexTasks(indexName, indexTypes));
  }

  private void indexBigFiles(JobContext jobContext) {
    jobContext.execute(new IndexBigFilesTask(properties.getEsUri()));
  }

  @SneakyThrows
  private Collection<? extends Task> createIndexTasks(final String indexName, Set<DocumentType> indexTypes) {
    return indexTypes.stream()
        .map(dt -> createIndexTask(indexName, dt))
        .collect(toImmutableList());
  }

  private IndexTask createIndexTask(String indexName, DocumentType documentType) {
    return new IndexTask(properties.getEsUri(), indexName, documentType, properties.getBigDocumentThresholdMb());
  }

  private Set<DocumentType> getIndexTypes() {
    if (properties.isBigDocumentsOnly()) {
      log.info("Indexing big documents only. Setting index types to {}...", DONOR_CENTRIC_TYPE);
      return Collections.singleton(DONOR_CENTRIC_TYPE);
    }

    val includeTypes = properties.getIncludeTypes();
    val excludeTypes = properties.getExcludeTypes();
    checkState(includeTypes.isEmpty() || excludeTypes.isEmpty(), "Indices can be either included, or excluded.");

    // All types
    if (includeTypes.isEmpty() && excludeTypes.isEmpty()) {
      return ImmutableSet.copyOf(DocumentType.values());
    }

    // Includes
    if (includeTypes.isEmpty() == false) {
      return includeTypes.stream()
          .map(type -> DocumentType.valueOf(type.toUpperCase()))
          .collect(toImmutableSet());
    }

    // Excludes
    val excludeDocumentTypes = excludeTypes.stream()
        .map(type -> DocumentType.valueOf(type.toUpperCase()))
        .collect(toImmutableSet());

    return difference(copyOf(DocumentType.values()), excludeDocumentTypes);
  }

}
