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
package org.icgc.dcc.etl2.job.export.model.type;

import static org.icgc.dcc.etl2.job.export.model.type.Constants.THERAPY_FIELD_NAME;

import java.util.Set;

import org.apache.spark.api.java.JavaRDD;
import org.icgc.dcc.etl2.core.function.FlattenField;
import org.icgc.dcc.etl2.core.function.ParseObjectNode;
import org.icgc.dcc.etl2.core.function.ProjectFields;
import org.icgc.dcc.etl2.core.function.PullUpField;
import org.icgc.dcc.etl2.core.function.RetainFields;
import org.icgc.dcc.etl2.job.export.function.AddDonorIdField;
import org.icgc.dcc.etl2.job.export.function.IsNonEmpty;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.collect.ImmutableMap;
import com.google.common.collect.Iterables;
import com.google.common.collect.Sets;

public class DonorTherapy implements Type {

  private final String DATA_TYPE_FOLDER = "donor";

  private static final ImmutableMap<String, String> FIRST_LEVEL_PROJECTION = ImmutableMap.<String, String> builder()
      .put("_donor_id", "icgc_donor_id")
      .put("_project_id", "project_code")
      .put("donor_id", "submitted_donor_id")
      .put(THERAPY_FIELD_NAME, THERAPY_FIELD_NAME)
      .build();

  private static final ImmutableMap<String, String> SECOND_LEVEL_PROJECTION = ImmutableMap.<String, String> builder()
      .put("donor_id", "donor_id")
      .put("first_therapy_type", "first_therapy_type")
      .put("first_therapy_therapeutic_intent", "first_therapy_therapeutic_intent")
      .put("first_therapy_start_interval", "first_therapy_start_interval")
      .put("first_therapy_duration", "first_therapy_duration")
      .put("first_therapy_response", "first_therapy_response")
      .put("second_therapy_type", "second_therapy_type")
      .put("second_therapy_therapeutic_intent", "second_therapy_therapeutic_intent")
      .put("second_therapy_start_interval", "second_therapy_start_interval")
      .put("second_therapy_duration", "second_therapy_duration")
      .put("second_therapy_response", "second_therapy_response")
      .put("other_therapy", "other_therapy")
      .put("other_therapy_response", "other_therapy_response")
      .build();

  @Override
  public JavaRDD<ObjectNode> process(JavaRDD<String> input) {
    return input
        .map(new ParseObjectNode())
        .map(new ProjectFields(FIRST_LEVEL_PROJECTION))
        .map(new AddDonorIdField())
        .filter(new IsNonEmpty(THERAPY_FIELD_NAME))
        .flatMap(new FlattenField(THERAPY_FIELD_NAME))
        .map(new PullUpField(THERAPY_FIELD_NAME))
        .map(new RetainFields(getFields()));
  }

  @Override
  public Set<String> getFields() {
    return Sets.newHashSet(Iterables.concat(FIRST_LEVEL_PROJECTION.values(), SECOND_LEVEL_PROJECTION.keySet()));
  }

  @Override
  public String getTypeDirectoryName() {
    return DATA_TYPE_FOLDER;
  }

}