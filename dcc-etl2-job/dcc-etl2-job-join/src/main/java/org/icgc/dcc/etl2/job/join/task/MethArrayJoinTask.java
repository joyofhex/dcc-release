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
package org.icgc.dcc.etl2.job.join.task;

import static org.icgc.dcc.etl2.core.util.FieldNames.JoinFieldNames.PROBE_ID;
import static org.icgc.dcc.etl2.core.util.JavaRDDs.createRddForJoin;

import java.util.Map;

import lombok.val;

import org.apache.spark.broadcast.Broadcast;
import org.icgc.dcc.etl2.core.function.KeyFields;
import org.icgc.dcc.etl2.core.job.FileType;
import org.icgc.dcc.etl2.core.task.TaskContext;
import org.icgc.dcc.etl2.job.join.model.DonorSample;

import scala.Tuple2;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.base.Optional;

public class MethArrayJoinTask extends PrimaryMetaJoinTask {

  private static final FileType PRIMARY_FILE_TYPE = FileType.METH_ARRAY_P;

  public MethArrayJoinTask(Broadcast<Map<String, Map<String, DonorSample>>> donorSamplesByProject) {
    super(donorSamplesByProject, PRIMARY_FILE_TYPE);
  }

  @Override
  public void execute(TaskContext taskContext) {
    sparkContext = taskContext.getSparkContext();
    val primaryMeta = joinPrimaryMeta(taskContext);
    val probes = readInput(taskContext, FileType.METH_ARRAY_PROBES);

    val keyFunction = new KeyFields(PROBE_ID);
    val output = primaryMeta
        .mapToPair(keyFunction)
        .leftOuterJoin(createRddForJoin(probes.mapToPair(keyFunction), sparkContext))
        .map(MethArrayJoinTask::combineProbes);

    writeOutput(taskContext, output, FileType.METH_ARRAY);
  }

  private static ObjectNode combineProbes(Tuple2<String, Tuple2<ObjectNode, Optional<ObjectNode>>> tuple) {
    val primary = tuple._2._1;
    val probe = tuple._2._2;
    if (probe.isPresent()) {
      primary.putAll(probe.get());
    }

    return primary;
  }

}
