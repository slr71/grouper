<%-- @annotation@ 
			Displays subject attributes
--%><%--
  @author Gary Brown.
  @version $Id: subjectInfo.jsp,v 1.9 2008-04-03 13:30:21 isgwb Exp $
--%>
<%@include file="/WEB-INF/jsp/include.jsp"%>
<tiles:importAttribute ignore="true"/>
<c:set var="subject" value="${viewObject}"/>
<div class="SubjectInfo">

<c:forEach var="attrName" items="${subjectAttributeNames}">
<c:set target="${subject}" property="useMulti" value="${navMap['subject.attribute.multi.separator']}"/>
<div class="formRow">
	<div class="formLeft">
		<c:out value="${attrName}"/>
	</div>
	<div class="formRight">
		<c:out value="${subject[attrName]}"/>
	</div>
</div>
 
</c:forEach>


	<c:set target="${listFieldParams}" property="groupId" value="${listFieldParams.subjectId}"/>
	<c:set target="${listFieldParams}" property="asMemberOf" value="${listFieldParams.subjectId}"/>
	<c:set target="${listFieldParams}" property="contextSubject" value="true"/>
	<c:set target="${listFieldParams}" property="contextSubjectId" value="${listFieldParams.subjectId}"/>
	<c:set target="${listFieldParams}" property="contextSubjectType" value="${listFieldParams.subjectType}"/>
		<c:set target="${listFieldParams}" property="contextSourceId" value="${listFieldParams.sourceId}"/>
<c:set target="${listFieldParams}" property="callerPageId" value="${thisPageId}"/>
<c:set target="${listFieldParams}" property="contextSubject" value=""/>

<c:forEach var="groupListField" items="${listFields}">
	<c:set target="${listFieldParams}" property="listField" value="${groupListField}"/>

<div class="formRow">
	<div class="formLeft">
		<c:out value="${groupListField}"/>
	</div>
	<div class="formRight">
		<html:link page="/populateGroupMembers.do" name="listFieldParams" >
	<grouper:message bundle="${nav}" key="subject.summary.view-list-field-members"><grouper:param value="${groupListField}"/></grouper:message></html:link>
	</div>
</div>
 
</c:forEach>
<div style="clear:left;"></div>
</div><!--/SubjectInfo-->

