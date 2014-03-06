<%@ include file="../assetsJsp/commonTaglib.jsp"%>

            <%-- for the new group or new stem button --%>
            <input type="hidden" name="objectStemId" value="${grouperRequestContainer.groupContainer.guiGroup.group.parentUuid}" />

            <div class="bread-header-container">
              <%--
              <ul class="breadcrumb">
                <li><a href="index.html">Home </a><span class="divider"><i class='icon-angle-right'></i></span></li>
                <li class="active">Applications</li>
              </ul>
              --%>
              ${grouperRequestContainer.groupContainer.guiGroup.breadcrumbs}
              <div class="page-header blue-gradient">
                <h1> <i class="icon-folder-close"></i> ${grouper:escapeHtml(grouperRequestContainer.groupContainer.guiGroup.group.displayExtension)}
                <br /><small>${textContainer.text['groupExportTitle'] }</small></h1>
              </div>
            </div>

            <form class="form-horizontal" id="groupExportTypeFormId">
              <div class="control-group">
                <label class="control-label">${textContainer.text['groupExportWhatData'] }</label>
                <div class="controls">
                  <label class="radio">
                    <input type="radio" name="group-export-options" value="ids" checked="checked"
                      onchange="ajax('../app/UiV2Group.groupExportTypeChange?groupId=${grouperRequestContainer.groupContainer.guiGroup.group.id}', {formIds: 'groupExportTypeFormId'}); return true;"
                      >${textContainer.text['groupExportEntityIds'] }
                  </label>
                  <label class="radio">
                    <input type="radio" name="group-export-options" value="all"
                      onchange="ajax('../app/UiV2Group.groupExportTypeChange?groupId=${grouperRequestContainer.groupContainer.guiGroup.group.id}', {formIds: 'groupExportTypeFormId'}); return true;"
                      >${textContainer.text['groupExportAllMemberData'] }    
                  </label>
                </div>
              </div>
              <div class="form-actions" id="formActionsDivId">
                <%@ include file="groupExportButtons.jsp"%>
              </div>
            </form>
