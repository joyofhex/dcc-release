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
package org.icgc.dcc.release.job.document.context;

import static com.google.common.base.Preconditions.checkArgument;
import static java.util.Collections.emptyList;

import org.icgc.dcc.release.core.document.DocumentType;
import org.icgc.dcc.release.job.document.core.DocumentJobContext;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.base.Optional;

public class MutationCentricDocumentContext extends DefaultDocumentContext {

  private final String mutationId;
  private final Optional<Iterable<ObjectNode>> observations;

  public MutationCentricDocumentContext(String mutationId, DocumentJobContext documentJobContext,
      Optional<Iterable<ObjectNode>> observations) {
    super(DocumentType.MUTATION_CENTRIC_TYPE, documentJobContext);
    this.mutationId = mutationId;
    this.observations = observations;
  }

  @Override
  public Iterable<ObjectNode> getObservationsByMutationId(String mutationId) {
    checkArgument(this.mutationId.equals(mutationId), "Context for mutation %s can't be used to retrieve observations "
        + "for mutation %s", this.mutationId, mutationId);

    return observations.isPresent() ? observations.get() : emptyList();
  }

}
