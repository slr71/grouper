/*
 * Copyright (C) 2004 University Corporation for Advanced Internet Development, Inc.
 * Copyright (C) 2004 The University Of Chicago
 * All Rights Reserved. 
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 *  * Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *  * Neither the name of the University of Chicago nor the names
 *    of its contributors nor the University Corporation for Advanced
 *   Internet Development, Inc. may be used to endorse or promote
 *   products derived from this software without explicit prior
 *   written permission.
 *
 * You are under no obligation whatsoever to provide any enhancements
 * to the University of Chicago, its contributors, or the University
 * Corporation for Advanced Internet Development, Inc.  If you choose
 * to provide your enhancements, or if you choose to otherwise publish
 * or distribute your enhancements, in source code form without
 * contemporaneously requiring end users to enter into a separate
 * written license agreement for such enhancements, then you thereby
 * grant the University of Chicago, its contributors, and the University
 * Corporation for Advanced Internet Development, Inc. a non-exclusive,
 * royalty-free, perpetual license to install, use, modify, prepare
 * derivative works, incorporate into the software or other computer
 * software, distribute, and sublicense your enhancements or derivative
 * works thereof, in binary and source code form.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND WITH ALL FAULTS.  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
 * BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT ARE DISCLAIMED AND the
 * entire risk of satisfactory quality, performance, accuracy, and effort
 * is with LICENSEE. IN NO EVENT SHALL THE COPYRIGHT OWNER, CONTRIBUTORS,
 * OR THE UNIVERSITY CORPORATION FOR ADVANCED INTERNET DEVELOPMENT, INC.
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OR DISTRIBUTION OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package test.edu.internet2.middleware.grouper;

import  edu.internet2.middleware.grouper.*;
import  edu.internet2.middleware.subject.*;
import  java.util.*;
import  junit.framework.*;


public class TestQueries extends TestCase {

  private String extn0    = "extn.0";
  private String extn1    = "extn.1";
  private String extn2    = "extn.2";
  private String klass    = "edu.internet2.middleware.grouper.GrouperQuery";
  private String klassGL  = "edu.internet2.middleware.grouper.GrouperList";
  private String m0id     = "blair";
  private String m0type   = "person";
  private String m1id     = "notblair";
  private String m1type   = "person";
  private String stem0    = "stem.0";
  private String stem1    = "stem.1";
  private String stem2    = "stem.2";

  public TestQueries(String name) {
    super(name);
  }

  protected void setUp () {
    // Nothing -- Yet
  }

  protected void tearDown () {
    // Nothing -- Yet
  }


  /*
   * TESTS
   */


  // Test requirements for other *real* tests
  public void testRequirements() {
    GrouperSession  s     = new GrouperSession();
    Assert.assertNotNull(s);
    Subject         subj  = GrouperSubject.lookup( Grouper.config("member.system"), "person" );
    Assert.assertNotNull(subj);
    s.start(subj);
    // Fetch the groups
    // g0
    GrouperGroup    g0  = GrouperGroup.lookup(s, stem0, extn0);
    Assert.assertNotNull(g0);
    // g1
    GrouperGroup    g1  = GrouperGroup.lookup(s, stem1, extn1);
    Assert.assertNotNull(g1);
    // g2
    GrouperGroup    g2  = GrouperGroup.lookup(s, stem2, extn2);
    Assert.assertNotNull(g2);
    // Fetch the members
    // Fetch Member 0
    GrouperMember   m0      = GrouperMember.lookup(m0id, m0type);
    Assert.assertNotNull(m0);
    // Fetch Member 1
    GrouperMember   m1      = GrouperMember.lookup(m1id, m1type);
    Assert.assertNotNull(m1);
    // We're done
    s.stop();
  }

  public void testQueryInstantiate() {
    GrouperSession  s     = new GrouperSession();
    Subject         subj  = GrouperSubject.lookup( Grouper.config("member.system"), "person" );
    s.start(subj);
    GrouperQuery    q0    = new GrouperQuery(s);
    Assert.assertNotNull(q0);
    Assert.assertTrue(klass.equals( q0.getClass().getName() ) );
    s.stop();
  }

  public void testQuery0() {
    //
    // g0 (g2)  ()
    // g1 ()    ()
    // g2 ()    ()
    //
    GrouperSession  s     = new GrouperSession();
    Subject         subj  = GrouperSubject.lookup( Grouper.config("member.system"), "person" );
    s.start(subj);

    // Create query object
    GrouperQuery    q     = new GrouperQuery(s);

    // We want MEM_ALL
    try {
      Assert.assertTrue( q.membership(Grouper.MEM_ALL) );
      List vals = q.query();
      Assert.assertNotNull(vals);
      Assert.assertTrue( vals.size() == 1 );
      Object obj = vals.get(0);
      Assert.assertNotNull(obj);
      Assert.assertTrue( klassGL.equals( obj.getClass().getName() ) );
    } catch (GrouperException e) {
      Assert.fail("Exception: MEM_ALL");
    }

    // We want MEM_EFF
    try {
      Assert.assertFalse( q.membership(Grouper.MEM_EFF) );
    } catch (GrouperException e) {
      Assert.fail("Exception: MEM_EFF");
    }

    // We want MEM_IMM
    try {
      Assert.assertTrue( q.membership(Grouper.MEM_IMM) );
      List vals = q.query();
      Assert.assertNotNull(vals);
      Assert.assertTrue( vals.size() == 1 );
      Object obj = vals.get(0);
      Assert.assertNotNull(obj);
      Assert.assertTrue( klassGL.equals( obj.getClass().getName() ) );
    } catch (GrouperException e) {
      Assert.fail("Exception: MEM_IMM");
    }

    // We're done
    s.stop(); 
  }

  public void testQuery1() {
    //
    // g0 (g2)  ()
    // g1 ()    ()
    // g2 ()    ()
    //
    GrouperSession  s     = new GrouperSession();
    Subject         subj  = GrouperSubject.lookup( Grouper.config("member.system"), "person" );
    s.start(subj);

    // Create query object
    GrouperQuery    q     = new GrouperQuery(s);

    // We want DEF_GROUP_TYPE + MEM_ALL
    try {
      // First DEF_GROUP_TYPE
      Assert.assertTrue( q.groupType(Grouper.DEF_GROUP_TYPE) );
      List vals = q.query();
      Assert.assertNotNull(vals);
      Assert.assertTrue( vals.size() == 1 );
      Object obj = vals.get(0);
      Assert.assertNotNull(obj);
      Assert.assertTrue( klassGL.equals( obj.getClass().getName() ) );
      // Now with MEM_ALL
      Assert.assertTrue( q.membership(Grouper.MEM_ALL) );
      vals = q.query();
      Assert.assertNotNull(vals);
      Assert.assertTrue( vals.size() == 1 );
      obj = vals.get(0);
      Assert.assertNotNull(obj);
      Assert.assertTrue( klassGL.equals( obj.getClass().getName() ) );
    } catch (GrouperException e) {
      Assert.fail("Exception: DEF_GROUP_TYPE,MEM_ALL");
    }

    // We want DEF_GROUP_TYPE + MEM_EFF
    try {
      q = new GrouperQuery(s); // FIXME
      // First DEF_GROUP_TYPE
      Assert.assertTrue( q.groupType(Grouper.DEF_GROUP_TYPE) );
      List vals = q.query();
      Assert.assertNotNull(vals);
      Assert.assertTrue( vals.size() == 1 );
      Object obj = vals.get(0);
      Assert.assertNotNull(obj);
      Assert.assertTrue( klassGL.equals( obj.getClass().getName() ) );
      // Now with MEM_ALL
      Assert.assertFalse( q.membership(Grouper.MEM_EFF) );
      vals = q.query();
      Assert.assertNotNull(vals);
      Assert.assertTrue( vals.size() == 0 );
    } catch (GrouperException e) {
      Assert.fail("Exception: DEF_GROUP_TYPE,MEM_EFF");
    }

    // We want DEF_GROUP_TYPE + MEM_IMM
    try {
      q = new GrouperQuery(s); // FIXME
      // First DEF_GROUP_TYPE
      Assert.assertTrue( q.groupType(Grouper.DEF_GROUP_TYPE) );
      List vals = q.query();
      Assert.assertNotNull(vals);
      Assert.assertTrue( vals.size() == 1 );
      Object obj = vals.get(0);
      Assert.assertNotNull(obj);
      Assert.assertTrue( klassGL.equals( obj.getClass().getName() ) );
      // Now with MEM_IMM
      Assert.assertTrue( q.membership(Grouper.MEM_IMM) );
      vals = q.query();
      Assert.assertNotNull(vals);
      Assert.assertTrue( vals.size() == 1 );
      obj = vals.get(0);
      Assert.assertNotNull(obj);
      Assert.assertTrue( klassGL.equals( obj.getClass().getName() ) );
    } catch (GrouperException e) {
      Assert.fail("Exception: DEF_GROUP_TYPE,MEM_IMM");
    }

    // We're done
    s.stop(); 
  }

  public void testQuery2() {
    //
    // g0 (g2)  ()
    // g1 ()    ()
    // g2 ()    ()
    //
    GrouperSession  s     = new GrouperSession();
    Subject         subj  = GrouperSubject.lookup( Grouper.config("member.system"), "person" );
    s.start(subj);

    // Create query object
    GrouperQuery    q     = new GrouperQuery(s);

    String naming = "naming";

    // We want `naming' + MEM_ALL
    try {
      // First `naming'
      Assert.assertFalse( q.groupType(naming) );
      // Now MEM_ALL
      Assert.assertTrue( q.membership(Grouper.MEM_ALL) );
      List vals = q.query();
      Assert.assertNotNull(vals);
      Assert.assertTrue( vals.size() == 0 );
    } catch (GrouperException e) {
      Assert.fail("Exception: DEF_GROUP_TYPE,MEM_ALL");
    }

    // We want DEF_GROUP_TYPE + MEM_EFF
    try {
      q = new GrouperQuery(s); // FIXME
      // First `naming'
      Assert.assertFalse( q.groupType(naming) );
      // Now MEM_EFF
      Assert.assertFalse( q.membership(Grouper.MEM_EFF) );
    } catch (GrouperException e) {
      Assert.fail("Exception: DEF_GROUP_TYPE,MEM_EFF");
    }

    // We want DEF_GROUP_TYPE + MEM_IMM
    try {
      q = new GrouperQuery(s); // FIXME
      // First `naming'
      Assert.assertFalse( q.groupType(naming) );
      // Now MEM_IMM
      Assert.assertTrue( q.membership(Grouper.MEM_IMM) );
      List vals = q.query();
      Assert.assertNotNull(vals);
      Assert.assertTrue( vals.size() == 0 );
    } catch (GrouperException e) {
      Assert.fail("Exception: DEF_GROUP_TYPE,MEM_IMM");
    }

    // We're done
    s.stop(); 
  }

}

