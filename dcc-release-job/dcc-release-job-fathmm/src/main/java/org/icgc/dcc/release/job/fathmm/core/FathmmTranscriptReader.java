/*
 * Copyright (c) 2014 The Ontario Institute for Cancer Research. All rights reserved.                             
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
package org.icgc.dcc.release.job.fathmm.core;

import static com.google.common.base.Stopwatch.createStarted;
import static com.google.common.base.Strings.isNullOrEmpty;
import static org.icgc.dcc.common.core.util.Formats.formatCount;
import static org.icgc.dcc.release.core.util.ObjectNodes.textValue;

import java.util.List;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.val;
import lombok.extern.slf4j.Slf4j;

import org.apache.spark.api.java.JavaRDD;
import org.icgc.dcc.release.core.function.FilterFields;
import org.icgc.dcc.release.core.function.FlattenField;
import org.icgc.dcc.release.core.function.PullUpField;
import org.icgc.dcc.release.core.job.FileType;
import org.icgc.dcc.release.core.task.GenericTask;
import org.icgc.dcc.release.core.task.TaskContext;
import org.icgc.dcc.release.core.util.ObjectNodeFilter.FilterMode;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.collect.BiMap;
import com.google.common.collect.ImmutableBiMap;

/**
 * Creates a one-to-one transcript->translation
 */
@Slf4j
@RequiredArgsConstructor
public class FathmmTranscriptReader extends GenericTask {

  /**
   * Constants.
   */
  private static final String GENE_TRANSCRIPTS = "transcripts";
  private static final String GENE_TRANSCRIPT_ID = "id";
  private static final String GENE_TRANSCRIPT_TRANSLATION_ID = "translation_id";

  @NonNull
  private final TaskContext taskContext;

  public BiMap<String, String> readTranscripts() {
    val watch = createStarted();
    log.info("Reading transcripts...");
    val input = readInput(taskContext, FileType.GENE);
    val transcripts = transform(input).collect();
    log.info("Finished reading {} transcripts in {}", formatCount(transcripts), watch);

    return transpose(transcripts);
  }

  private JavaRDD<ObjectNode> transform(JavaRDD<ObjectNode> input) {
    return input
        .map(
            new FilterFields(FilterMode.INCLUDE,
                GENE_TRANSCRIPTS + "." + GENE_TRANSCRIPT_ID,
                GENE_TRANSCRIPTS + "." + GENE_TRANSCRIPT_TRANSLATION_ID))
        .flatMap(new FlattenField(GENE_TRANSCRIPTS))
        .map(new PullUpField(GENE_TRANSCRIPTS));
  }

  private BiMap<String, String> transpose(List<ObjectNode> transcripts) {
    val mapping = ImmutableBiMap.<String, String> builder();
    for (val transcript : transcripts) {
      val transcriptId = textValue(transcript, GENE_TRANSCRIPT_ID);
      val translationId = textValue(transcript, GENE_TRANSCRIPT_TRANSLATION_ID);
      if (isNullOrEmpty(translationId) || isNullOrEmpty(transcriptId)) {
        continue;
      }

      mapping.put(transcriptId, translationId);
    }

    return mapping.build();
  }

  @Override
  public void execute(TaskContext taskContext) {
    throw new UnsupportedOperationException();
  }

}
