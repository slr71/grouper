<!--
  $Id: personview.jsp,v 1.1 2004-12-09 20:49:07 mnguyen Exp $
  $Date: 2004-12-09 20:49:07 $
  
  Copyright 2004 Internet2 and Stanford University.  All Rights Reserved.
  Licensed under the Signet License, Version 1,
  see doc/license.txt in this distribution.
-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <meta name="robots" content="noindex, nofollow" />
  <title>
    Signet
  </title>
  <link href="styles/signet.css" rel="stylesheet" type="text/css" />
  <script language="JavaScript" type="text/javascript" src="scripts/signet.js"></script>
</head>

<body>
  <script type="text/javascript">
    function selectThis(isChecked)
    {
      var theCheckAllBox = document.checkform.checkAll;
      if (!isChecked)
      {
        theCheckAllBox.checked = false;
      }
      
      if (selectCount() > 0)
      {
        document.checkform.revokeButton.disabled = false;
      }
      else
      {
        document.checkform.revokeButton.disabled = true;
      }
    }
    
    function selectAll(isChecked)
    {
      var theForm = document.checkform;

      for (var i = 0; i < theForm.elements.length; i++)
      {
        if (theForm.elements[i].name != 'checkAll'
            && theForm.elements[i].type == 'checkbox'
            && theForm.elements[i].disabled == false)
        {
          theForm.elements[i].checked = isChecked;
        }
      }
      
      if (selectCount() > 0)
      {
        document.checkform.revokeButton.disabled = false;
      }
      else
      {
        document.checkform.revokeButton.disabled = true;
      }
    }
    
    function selectCount()
    {
      var theForm = document.checkform;
      var count = 0;
      
      for (var i = 0; i < theForm.elements.length; i++)
      {
        if ((theForm.elements[i].name != 'checkAll')
            && (theForm.elements[i].type == 'checkbox')
            && (theForm.elements[i].checked == true))
        {
          count++;
        }
      }
      
      return count;
    }
  </script>

<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.SortedSet" %>
<%@ page import="java.util.TreeSet" %>
<%@ page import="java.util.HashSet" %>

<%@ page import="edu.internet2.middleware.signet.Signet" %>
<%@ page import="edu.internet2.middleware.signet.PrivilegedSubject" %>
<%@ page import="edu.internet2.middleware.signet.Subsystem" %>
<%@ page import="edu.internet2.middleware.signet.Category" %>
<%@ page import="edu.internet2.middleware.signet.Assignment" %>
<%@ page import="edu.internet2.middleware.signet.Function" %>
<%@ page import="edu.internet2.middleware.signet.Status" %>

<% 
  Signet signet
     = (Signet)
         (request.getSession().getAttribute("signet"));
         
   PrivilegedSubject loggedInPrivilegedSubject
     = (PrivilegedSubject)
         (request.getSession().getAttribute("loggedInPrivilegedSubject"));
   
   PrivilegedSubject currentGranteePrivilegedSubject
     = (PrivilegedSubject)
         (request.getSession().getAttribute("currentGranteePrivilegedSubject"));
         
   Subsystem currentSubsystem
     = (Subsystem)
         (request.getSession().getAttribute("currentSubsystem"));
         
   Set grantableSubsystems = loggedInPrivilegedSubject.getGrantableSubsystems();
         
   DateFormat dateFormat = DateFormat.getDateInstance();
%>
  <div id="Header">  
    <div id="Logo">
      <img src="images/KITN.gif" width="216" height="60" alt="logo" />
    </div> <!-- Logo -->
    <div id="Signet">
      <img
        src="images/signet.gif"
        alt="Signet"
        height="60"
        width="49">
    </div> <!-- Signet -->
  </div> <!-- Header -->
    
  <div id="Navbar">
    <span class="logout">
      <a href="NotYetImplemented.do">
        <%= loggedInPrivilegedSubject.getName() %>: Logout
      </a>
    </span> <!-- logout -->
    <span class="select">
      <a href="Start.do">
        Home
      </a>
      > <%=currentGranteePrivilegedSubject.getName()%>
    </span> <!-- select -->
  </div> <!-- Navbar -->
  
  <div id="Layout"> 
    <div id="Content">
      <div class="table1">
        Privileges assigned to
        <h1>
          <%=currentGranteePrivilegedSubject.getName()%>
        </h1>
        <span class="dropback">
          <%=currentGranteePrivilegedSubject.getDescription()%>
        </span> <!-- dropback -->	
        <br />
        <div class="tableheader">
          <form name="pickSubsystem" action="PersonView.do" style="margin: 0px;">
            <!-- the following two a tags must be within the form tag, but
                 before the generated text that appears in the tableheader row -->
            <a
              style="float: right;"
              href="javascript:;"
              onClick="alert('This will download the data shown in the table in an Excel-readable format.')">
              <img
                src="images/icon_spread.gif"
                width="20"
                height="20"
                class="icon"
                style="margin-left: 10px;" />
              Export to Excel
            </a>
            <a
              style="float: right;"
              href="PersonViewPrint.do">
              <img
                src="images/icon_printsion.gif"
                width="21"
                height="20"
                class="icon" />
              Printable version
            </a>
            <%=(currentSubsystem == null ? "NO ASSIGNED" : currentSubsystem.getName())%> Privileges
            <select
              name="subsystemId"
              class="long"
              id="subsystem">

              <option
                selected="selected"
                onClick="javascript:document.pickSubsystem.showSubsystemPrivs.disabled=true">
                (assigned privilege types)
              </option>
              
<%
  Set assignmentsReceived
  	= new TreeSet
  			(currentGranteePrivilegedSubject
  				.getAssignmentsReceived(Status.ACTIVE, null));
  Set subsystemsOfReceivedAssignments = new HashSet();
  Iterator assignmentsReceivedIterator
  	= assignmentsReceived.iterator();
  while (assignmentsReceivedIterator.hasNext())
  {
    Assignment receivedAssignment
      = (Assignment)(assignmentsReceivedIterator.next());
    subsystemsOfReceivedAssignments.add
    	(receivedAssignment.getSubsystem());
  }

  Iterator subsystemsIterator
  	= subsystemsOfReceivedAssignments.iterator();
  while (subsystemsIterator.hasNext())
  {
    Subsystem subsystem = (Subsystem)(subsystemsIterator.next());
%>
              <option
                value="<%=subsystem.getId()%>"
                onClick="javascript:document.pickSubsystem.showSubsystemPrivs.disabled=false">
                <%=subsystem.getName()%>
              </option>
              
<%
  }
%>

            </select>
                    
            <input
              class="button1"
              disabled="true"
              type="submit"
              name="showSubsystemPrivs"
              value="Show"/>
          </form> <!-- pickSubsystem -->
        </div> <!-- tableheader -->
            
        <form
          onSubmit
            ="return confirm
               ('Are you sure you want to revoke the '
                + (selectCount() == 1 ? '' : selectCount())
                + ' selected assignment'
                + (selectCount() > 1 ? 's' : '')
                + '?'
                + ' This action cannot be undone.'
                + ' Click OK to confirm.');"
          action="Revoke.do"
          method="post"
          name="checkform"
          id="checkform">
          <div class="tablecontent">
            <table class="full">
              <tr class="columnhead">
                <td width="30%">
                  <img
                    src="images/icon_down_unsel.gif"
                    width="17"
                    height="17" />
                  Privilege
                </td>
                <td width="20%">
                  Scope
                </td>
                <td>
                  Limits
                </td>
                <td width="10%" align="left">
                  All:
                  <input
                    name="checkAll"
                    type="checkbox"
                    id="checkAll"
                    onClick="selectAll(this.checked);"
                    value="Check All" />
                </td>
              </tr>
                
<%
  if (currentSubsystem != null)
  {
    Set assignmentsReceivedForCurrentSubsystem
      = new TreeSet
      		(currentGranteePrivilegedSubject
      			.getAssignmentsReceived(Status.ACTIVE, currentSubsystem));
    Iterator assignmentsIterator
    	= assignmentsReceivedForCurrentSubsystem.iterator();
    while (assignmentsIterator.hasNext())
    {
      Assignment assignment = (Assignment)(assignmentsIterator.next());
%>

                <tr class="line" >
                  <td class="line" >
                    <a
                      style="float: right;"
                      href="javascript:openWindow
                              ('Assignment.do?assignmentId=<%=assignment.getId()%>',
                      	       'popup',
                      	       'scrollbars=yes,
                      	        resizable=yes,
                      	        width=500,
                      	        height=100');">
                      <img
                        src="images/info.gif"
                        width="20"
                        height="20" />
                    </a>
                    <%=assignment.getFunction().getCategory().getName()%>
                    : 
                    <%=assignment.getFunction().getName()%>
                  </td>
                  <td class="line" >
                    <%=assignment.getScope().getName()%>
                  </td>
                  <td class="line"  >
                    <a
                      style="float: right;"
                      href="NotYetImplemented.do">
                      <img
                        src="images/icon_arrow_right.gif"
                        width="16"
                        height="16"
                        class="icon" />
                      edit
                    </a>
                    <span class="dropback">
                      <!--Approval limit:--> 
                    </span>
                    <!--$500-->
                    <br />
                    <span class="dropback">
                      <!--Account:--> 
                    </span>
                    <!--1003321, 1003329-567, 1003329-992, 1003354, 1003372-001-->
                  </td>
                  <td align="center" class="line"  >
                    <input
                      name="revoke"
                      type="checkbox"
                      id="<%=assignment.getId()%>"
                      value="<%=assignment.getId()%>"
                      <%=(loggedInPrivilegedSubject.canEdit(assignment) ? "" : "disabled=\"true\"")%>
                      onClick="selectThis(this.checked);">
                  </td>
                </tr>
                
<%
    }
  }
%>

                <tr class="line"  >
                  <td class="line" >&nbsp;
                    
                  </td>
                  <td class="line" >&nbsp;
                    
                  </td>
                  <td class="line"  >&nbsp;
                    
                  </td>
                  <td align="center" class="line"  >
                    <input
                      name="revokeButton"
                      type="submit"
                      disabled="true"
                      class="button1"
                      value="Revoke" />
                  </td>
                </tr>
              </table>
            </div> <!-- tablecontent -->
          </form> <!-- checkform -->
        </div> <!-- table1 -->
        <jsp:include page="footer.jsp" flush="true" />
      </div> <!-- Content -->
      <div id="Sidebar">
        
<% 
  if (!(currentGranteePrivilegedSubject.equals(loggedInPrivilegedSubject)))
  {
%>

        <div class="box1">
          <div class="actionheader">
            Grant to <%=currentGranteePrivilegedSubject.getName()%>
          </div> <!-- actionheader -->
          <form action="Functions.do">
            <div class="actionbox"> 
              <p>
                <span class="tableheader">
                  <select name="select" class="long">
<!--
                    <option selected="selected">
                      (privileges you can grant)
                    </option>
-->

<%
    Iterator grantableSubsystemsIterator = grantableSubsystems.iterator();
    while (grantableSubsystemsIterator.hasNext())
    {
      Subsystem subsystem = (Subsystem)(grantableSubsystemsIterator.next());
%>
                    <option value="<%=subsystem.getId()%>">
                      <%=subsystem.getName()%>
                    </option>
<%
    }
%>
                  </select>
                </span> <!-- tableheader --> 
                <input
                  type="submit"
                  name="Button"
                  class="button2"
                  <%=grantableSubsystems.size()==0 ? "disabled=\"disabled\"" : ""%>
                  value="Start &gt;&gt;" />
                </p>
              </div> <!-- actionbox -->
            </form>
          </div> <!-- box1 -->
          
<%
  }
%>
          
          <div class="box1">
            <div class="actionheader">
              View privileges...
            </div> <!-- actionheader -->
            <div class="actionbox">
              <p>
                <a href="Start.do">
                  <img
                    src="images/icon_arrow_right.gif"
                    width="16"
                    height="16"
                    class="icon" />
                  you have granted (home page)
                </a>
              </p>
              <p>
                <a href="PersonView.do?granteeSubjectTypeId=<%=loggedInPrivilegedSubject.getSubjectTypeId()%>&granteeSubjectId=<%=loggedInPrivilegedSubject.getSubjectId()%>">
                  <img
                    src="images/icon_arrow_right.gif"
                    width="16"
                    height="16"
                    class="icon" />
                  assigned to you
                </a>
              </p>
              <p>
                <a href="NotYetImplemented.do">
                  <img
                   src="images/icon_arrow_right.gif"
                   width="16"
                   height="16"
                   class="icon" />
                  by type &amp; scope
                </a>
              </p>
            </div> <!-- actionbox -->
          </div> <!-- box1 -->
            
          <div class="box1">
            <div class="actionheader">
              find a person
            </div> <!-- actionheader -->
            
            <div class="actionbox">
              <p>
                <input
                  name="words"
                  type="text"
                  class="short"
                  id="words"
                  style="width:100px"
                  size="15"
                  maxlength="500" />
                <input
                  name="searchbutton"
                  type="button"
                  class="button1"
                  onClick="javascript:showResult();"
                  value="Search" />
              </p>
              <div id="Results" style="display:none">
                Your search found:
                <ol>
          
<%
  Set privilegedSubjects
    = signet.getPrivilegedSubjects();
      
  SortedSet sortSet = new TreeSet(privilegedSubjects);
  Iterator sortSetIterator = sortSet.iterator();
  while (sortSetIterator.hasNext())
  {
    PrivilegedSubject listSubject
      = (PrivilegedSubject)(sortSetIterator.next());
%>

                <li>
                  <a href="PersonView.do?granteeSubjectTypeId=<%=listSubject.getSubjectTypeId()%>&granteeSubjectId=<%=listSubject.getSubjectId()%>">
                    <%=listSubject.getName()%>
                  </a>
                  <br />
                  <%=listSubject.getDescription()%>
                </li>
<%
  }
%>
              </ol>
            </div> <!-- results -->
          </div> <!-- actionbox -->
        </div> <!-- box1 -->
      </div> <!-- Sidebar -->
    </div> <!-- Layout -->
  </body>
</html>
