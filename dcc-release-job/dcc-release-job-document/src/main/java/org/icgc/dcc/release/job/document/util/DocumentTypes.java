/*
 * Copyright (c) 2015 The Ontario Institute for Cancer Research. All rights reserved.                             
 *                                                                                                               
 * This program and the accompanying materials are made available under the terms of the GNU Public License v3.0.
 * You should have received a copy of the GNU General Public License along with                                  
 * this program. If not, see <http://www.gnu.org/licenses/>.                                                     
 *                                                                                                               
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY                           
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES                          
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT                           
 * SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,                                
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED                          
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;                               
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER                              
 * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN                         
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
package org.icgc.dcc.release.job.document.util;

import static com.google.common.base.Preconditions.checkState;
import static com.google.common.collect.ImmutableList.of;
import static lombok.AccessLevel.PRIVATE;

import java.util.Collection;
import java.util.Map;

import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.val;

import org.icgc.dcc.release.core.document.DocumentType;
import org.icgc.dcc.release.job.document.model.BroadcastType;
import org.icgc.dcc.release.job.document.model.CollectionFields;
import org.icgc.dcc.release.job.document.model.DocumentFields;
import org.icgc.dcc.release.job.document.model.DocumentTypeAttributes;
import org.icgc.dcc.release.job.document.task.DiagramDocumentTask;
import org.icgc.dcc.release.job.document.task.DonorCentricDocumentTask;
import org.icgc.dcc.release.job.document.task.DonorDocumentTask;
import org.icgc.dcc.release.job.document.task.DonorTextDocumentTask;
import org.icgc.dcc.release.job.document.task.GeneCentricDocumentTask;
import org.icgc.dcc.release.job.document.task.GeneDocumentTask;
import org.icgc.dcc.release.job.document.task.GeneSetDocumentTask;
import org.icgc.dcc.release.job.document.task.GeneSetTextDocumentTask;
import org.icgc.dcc.release.job.document.task.GeneTextDocumentTask;
import org.icgc.dcc.release.job.document.task.MutationCentricDocumentTask;
import org.icgc.dcc.release.job.document.task.MutationTextDocumentTask;
import org.icgc.dcc.release.job.document.task.ObservationCentricDocumentTask;
import org.icgc.dcc.release.job.document.task.ProjectDocumentTask;
import org.icgc.dcc.release.job.document.task.ProjectTextDocumentTask;
import org.icgc.dcc.release.job.document.task.ReleaseDocumentTask;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;

@NoArgsConstructor(access = PRIVATE)
public final class DocumentTypes {

  private static final Map<DocumentType, DocumentTypeAttributes> DOCUMENT_TYPES = defineDocumentTypes();

  public static String getIndexClassName(@NonNull DocumentType documentType) {
    return DOCUMENT_TYPES.get(documentType).indexClassName();
  }

  public static Collection<BroadcastType> getBroadcastDependencies(@NonNull DocumentType documentType) {
    return DOCUMENT_TYPES.get(documentType).broadcastDependencies();
  }

  public static DocumentFields getFields(@NonNull DocumentType documentType) {
    return DOCUMENT_TYPES.get(documentType).fields();
  }

  private static Map<DocumentType, DocumentTypeAttributes> defineDocumentTypes() {
    val documentTypes =
        ImmutableMap
            .<DocumentType, DocumentTypeAttributes> builder()
            .put(DocumentType.DIAGRAM_TYPE, attributes().indexClassName(DiagramDocumentTask.class.getName()))
            .put(DocumentType.RELEASE_TYPE, attributes().indexClassName(ReleaseDocumentTask.class.getName()))

            .put(DocumentType.GENE_SET_TYPE,
                attributes()
                    .indexClassName(GeneSetDocumentTask.class.getName())
                    .fields(fields()
                        .geneFields(
                            geneFields()
                                .includedFields(
                                    "_gene_id",

                                    // Gene sets
                                    "sets.id",
                                    "sets.type",

                                    "project._project_id",
                                    "donor")
                        )
                        .projectFields(
                            projectFields()
                                .includedFields(
                                    "_project_id",
                                    "project_name",
                                    "primary_site",
                                    "tumour_type",
                                    "tumour_subtype",
                                    "_summary._ssm_tested_donor_count",
                                    "_summary._total_donor_count")
                        )
                    )
            )
            .put(DocumentType.GENE_SET_TEXT_TYPE,
                attributes()
                    .indexClassName(GeneSetTextDocumentTask.class.getName())
                    .fields(fields()
                        .geneSetFields(
                            geneSetFields()
                                .includedFields(
                                    "id",
                                    "name",
                                    "type",
                                    "source",
                                    "go_term.alt_ids")
                        )
                    )
            )

            .put(DocumentType.PROJECT_TYPE, attributes().indexClassName(ProjectDocumentTask.class.getName()))
            .put(DocumentType.PROJECT_TEXT_TYPE,
                attributes()
                    .indexClassName(ProjectTextDocumentTask.class.getName())
                    .fields(fields()
                        .projectFields(
                            projectFields()
                                .includedFields(
                                    "_project_id",
                                    "project_name",
                                    "tumour_type",
                                    "tumour_subtype",
                                    "primary_site",
                                    "_summary._state")
                        )
                    )
            )

            .put(DocumentType.DONOR_TYPE,
                attributes()
                    .indexClassName(DonorDocumentTask.class.getName())
                    .broadcastDependencies(ImmutableList.of(BroadcastType.PROJECT))
                    .fields(fields()
                        .donorFields(
                            donorFields()
                                .excludedFields(
                                    "_id",
                                    "gene")
                        )
                    )
            )
            .put(DocumentType.DONOR_TEXT_TYPE,
                attributes()
                    .indexClassName(DonorTextDocumentTask.class.getName())
                    .fields(fields()
                        .donorFields(
                            donorFields()
                                .includedFields(
                                    "_donor_id",
                                    "_project_id",
                                    "donor_id",
                                    "specimen._specimen_id",
                                    "specimen.specimen_id",
                                    "specimen.sample._sample_id",
                                    "specimen.sample.analyzed_sample_id",
                                    "_summary._state")
                        )
                    )
            )
            .put(DocumentType.DONOR_CENTRIC_TYPE,
                attributes()
                    .indexClassName(DonorCentricDocumentTask.class.getName())
                    .broadcastDependencies(ImmutableList.of(BroadcastType.GENE, BroadcastType.PROJECT))
                    .fields(fields()
                        .projectFields(
                            projectFields()
                                .includedFields(
                                    // Primary key
                                    "_project_id",

                                    // Data
                                    "primary_site",
                                    "project_name")
                        )
                        .donorFields(
                            donorFields()
                                .includedFields(
                                    // Primary key
                                    "_donor_id",

                                    // Foreign keys
                                    "_project_id",

                                    // Summary
                                    "gene._gene_id",
                                    "gene._summary._ssm_count",
                                    "_summary",

                                    // Data
                                    "donor_id",
                                    "disease_status_last_followup",
                                    "donor_age_at_diagnosis",
                                    "donor_age_at_enrollment",
                                    "donor_age_at_last_followup",
                                    "donor_diagnosis_icd10",
                                    "donor_interval_of_last_followup",
                                    "donor_relapse_interval",
                                    "donor_relapse_type",
                                    "donor_sex",
                                    "donor_survival_time",
                                    "donor_tumour_stage_at_diagnosis",
                                    "donor_tumour_stage_at_diagnosis_supplemental",
                                    "donor_tumour_staging_system_at_diagnosis",
                                    "donor_vital_status")
                        )
                        .geneFields(
                            geneFields()
                                .includedFields(
                                    // Primary key
                                    "_gene_id",

                                    // Data
                                    "symbol",
                                    "biotype",
                                    "chromosome",
                                    "start",
                                    "end",

                                    // Gene sets
                                    "sets.id",
                                    "sets.type")
                        )
                        .observationFields(
                            observationFields()
                                .includedFields(
                                    // Foreign keys
                                    "_mutation_id",
                                    "_donor_id", // TODO: New from ETL1! Needed due to lack of MongoDB
                                    "consequence._gene_id",

                                    // Data
                                    "consequence.consequence_type",
                                    "consequence.functional_impact_prediction_summary",
                                    "_type",
                                    "mutation_type",
                                    "platform",
                                    "validation_status",
                                    "verification_status",
                                    "chromosome",
                                    "chromosome_end",
                                    "chromosome_start",
                                    "observation")
                        )
                    )
            )

            .put(DocumentType.GENE_TYPE,
                attributes()
                    .indexClassName(GeneDocumentTask.class.getName())
                    .fields(fields()
                        .geneFields(geneFields()
                            .excludedFields("donor")
                        )
                        .observationFields(
                            observationFields()
                                .excludedFields(
                                    "_id",
                                    "_summary",
                                    "project",
                                    "donor")
                        )
                    )
            )
            .put(DocumentType.GENE_TEXT_TYPE,
                attributes()
                    .indexClassName(GeneTextDocumentTask.class.getName())
                    .fields(fields()
                        .geneFields(
                            geneFields()
                                .includedFields(
                                    "_gene_id",
                                    "symbol",
                                    "name",
                                    "synonyms",
                                    "external_db_ids")
                        )
                    )
            )
            .put(DocumentType.GENE_CENTRIC_TYPE,
                attributes()
                    .indexClassName(GeneCentricDocumentTask.class.getName())
                    .broadcastDependencies(ImmutableList.of(BroadcastType.DONOR, BroadcastType.PROJECT))
                    .fields(fields()
                        .donorFields(
                            donorFields()
                                .excludedFields(
                                    "_id",
                                    "gene",
                                    "specimen")
                        )
                        .observationFields(
                            observationFields()
                                .excludedFields(
                                    "_id",
                                    "functional_impact_prediction_summary",
                                    "consequence.functional_impact_prediction")
                        )
                    )
            )

            .put(
                DocumentType.OBSERVATION_CENTRIC_TYPE,
                attributes()
                    .indexClassName(ObservationCentricDocumentTask.class.getName())
                    .broadcastDependencies(of(BroadcastType.DONOR, BroadcastType.PROJECT, BroadcastType.GENE))
                    .fields(fields()
                        .projectFields(
                            projectFields()
                                .includedFields(
                                    "_project_id",
                                    "project_name",
                                    "primary_site")
                        )
                        .donorFields(
                            donorFields()
                                .excludedFields(
                                    "_id",
                                    "gene",
                                    "specimen")
                        )
                        .geneFields(
                            geneFields()
                                .excludedFields(
                                    "_id",
                                    "project",
                                    "donor",
                                    "transcripts")

                        )
                        .observationFields(
                            observationFields()
                                .excludedFields(
                                    "_id",
                                    "functional_impact_prediction_summary",
                                    "consequence.functional_impact_prediction")
                        )
                    )
            )

            .put(DocumentType.MUTATION_TEXT_TYPE,
                attributes()
                    .indexClassName(MutationTextDocumentTask.class.getName())
                    .broadcastDependencies(ImmutableList.of(BroadcastType.GENE))
                    .fields(fields()
                        .mutationFields(
                            mutationFields()
                                .includedFields(
                                    "_mutation_id",
                                    "mutation",
                                    "chromosome",
                                    "chromosome_start")
                        )

                        .observationFields(
                            observationFields()
                                .includedFields(
                                    "_mutation_id",
                                    "consequence._gene_id",
                                    "consequence.aa_mutation",
                                    "mutation")
                        )
                        .geneFields(
                            geneFields()
                                .includedFields(
                                    "_gene_id",
                                    "symbol")
                        )
                    )
            )
            .put(
                DocumentType.MUTATION_CENTRIC_TYPE,
                attributes()
                    .indexClassName(MutationCentricDocumentTask.class.getName())
                    .broadcastDependencies(of(BroadcastType.DONOR, BroadcastType.PROJECT, BroadcastType.GENE))
                    .fields(fields()
                        .donorFields(
                            donorFields()
                                .excludedFields(
                                    "_id",
                                    "gene",
                                    "specimen")
                        )
                        .geneFields(
                            geneFields()
                                .excludedFields(
                                    "_id",
                                    "project",
                                    "donor",
                                    "transcripts.domains",
                                    "transcripts.exons")

                        )
                    )
            )
            .build();

    checkState(documentTypes.size() == DocumentType.values().length);

    return documentTypes;
  }

  private static DocumentTypeAttributes attributes() {
    return new DocumentTypeAttributes();
  }

  private static DocumentFields.Builder fields() {
    return DocumentFields.documentFields();
  }

  private static CollectionFields.Builder geneFields() {
    return CollectionFields.collectionFields();
  }

  private static CollectionFields.Builder projectFields() {
    return CollectionFields.collectionFields();
  }

  private static CollectionFields.Builder donorFields() {
    return CollectionFields.collectionFields();
  }

  private static CollectionFields.Builder observationFields() {
    return CollectionFields.collectionFields();
  }

  private static CollectionFields.Builder mutationFields() {
    return CollectionFields.collectionFields();
  }

  private static CollectionFields.Builder geneSetFields() {
    return CollectionFields.collectionFields();
  }

}