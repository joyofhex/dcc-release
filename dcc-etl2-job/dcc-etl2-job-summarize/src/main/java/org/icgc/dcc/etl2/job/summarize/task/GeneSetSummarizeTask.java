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
package org.icgc.dcc.etl2.job.summarize.task;

import static org.icgc.dcc.common.core.model.FieldNames.GENE_SETS;
import static org.icgc.dcc.common.core.model.FieldNames.GENE_SETS_TYPE;
import static org.icgc.dcc.common.core.model.FieldNames.GENE_SET_ID;
import static org.icgc.dcc.etl2.core.function.UnwindToPair.unwind;
import static org.icgc.dcc.etl2.core.job.FileType.GENE_SET_SUMMARY;
import static org.icgc.dcc.etl2.core.util.FieldNames.SummarizeFieldNames.GENE_NAME;
import static org.icgc.dcc.etl2.core.util.Tuples.tuple;
import lombok.val;

import org.apache.spark.api.java.JavaPairRDD;
import org.icgc.dcc.etl2.core.function.CombineFields;
import org.icgc.dcc.etl2.core.function.KeyFields;
import org.icgc.dcc.etl2.core.function.RemoveFields;
import org.icgc.dcc.etl2.core.job.FileType;
import org.icgc.dcc.etl2.core.task.GenericTask;
import org.icgc.dcc.etl2.core.task.TaskContext;
import org.icgc.dcc.etl2.job.summarize.function.AddGeneSetSummary;

import com.fasterxml.jackson.databind.node.ObjectNode;

public class GeneSetSummarizeTask extends GenericTask {

  @Override
  public void execute(TaskContext taskContext) {
    val geneSets = readGeneSets(taskContext);
    val genePairs = readGenePairs(taskContext);
    val geneSetsCount = geneSets.join(genePairs)
        .mapToPair(t -> tuple(t._1, 1))
        .reduceByKey((a, b) -> a + b);

    val summary = geneSets.leftOuterJoin(geneSetsCount)
        .map(new AddGeneSetSummary());

    writeOutput(taskContext, summary, GENE_SET_SUMMARY);
  }

  private JavaPairRDD<String, ObjectNode> readGeneSets(TaskContext taskContext) {
    return readInput(taskContext, FileType.GENE_SET)
        .mapToPair(new KeyFields(GENE_SET_ID, GENE_SETS_TYPE));
  }

  private JavaPairRDD<String, String> readGenePairs(TaskContext taskContext) {
    val genes = readInput(taskContext, FileType.GENE);
    val keyFunction = new CombineFields(GENE_SET_ID, GENE_SETS_TYPE);
    return genes
        // Remove duplicate fields between gene and gene.sets to allow further unwind
        .map(new RemoveFields(GENE_NAME))
        // Map value of the pair to empty string as it's not used
        .flatMapToPair(unwind(GENE_SETS, keyFunction, t -> null));
  }

}
