<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>Students</h1>
<p class="bottom30">
	This page displays all students.
	<br /><br />
	Vivamus aliquam nec risus sed condimentum. Duis fringilla, urna a posuere vehicula, mi libero dictum tortor, ac tincidunt quam 
	odio et justo. Nulla facilisi. Phasellus neque ipsum, rutrum a consequat a, lacinia nec nisl. Nunc at odio neque. Ut ornare 
	sodales turpis non venenatis. Donec ornare purus ut nibh interdum posuere.<br />
	Litora torquent per conubia nostra, per inceptos himenaeos. Nam at aliquam nisi. 
	Pellentesque at ante dictum, iaculis velit vitae, tincidunt metus. Donec volutpat, lacus eget ultricies semper, 
	nisl dolor tempus lorem, vitae vulputate ipsum turpis vel tortor. Nam ornare dictum lacus, vitae volutpat neque ultricies vitae. 
	Vivamus ut nulla tellus. Suspendisse potenti. Cras venenatis orci tempor rhoncus vehicula. Fusce pellentesque orci dictum, 
	rhoncus arcu nec, porttitor erat. Sed sed urna et lacus tincidunt aliquam et sed lectus.	
</p>

<% // Info and error messages. Hidden by deffault %>
<div id="infoMessage" class="bs-callout bs-callout-info <c:if test="${empty infoMessage}">hidden</c:if>">
	<c:out value="${infoMessage}" />
</div>

<div id="errorMessage" class="bs-callout bs-callout-danger <c:if test="${empty errorMessage}">hidden</c:if>">
	<c:out value="${errorMessage}" />
</div>

<% // New student button at the top should be displayed only if the amount of results per page is > 10 %>
<c:if test="${resultList.pageSize > 10}">
	<a href='<s:url value="/staff/studentcreate" />' class="btn btn-default bottom20">New Student User</a>
</c:if>

<table class="table table-bordered table-striped table-responsive">
	<thead>
		<tr>
			<th>#</th>
			<th>Name</th>
			<th>Username</th>
			<th>Email</th>
			<th>Phone</th>
			<th>Type</th>
			<th>Enabled</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList.pageList}" var="studentUser" varStatus="status">
			<tr>
				<td><c:out value="${resultList.pageSize * resultList.page + status.count}" /></td>
				<td><c:out value="${studentUser.firstName} ${studentUser.lastName}" /></td>
				<td>
					<a href='<s:url value="/staff/studentedit/${studentUser.username}" />'>
						<c:out value="${studentUser.username}" />
					</a>
				</td>
				<td><c:out value="${studentUser.email}" /></td>
				<td><c:out value="${studentUser.phone}" /></td>
				<td><c:out value="${studentUser.type}" /></td>
				<td>
					<c:choose>
						<c:when test="${studentUser.enabled == 1}">Yes</c:when>
						<c:when test="${studentUser.enabled == 0}">No</c:when>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>


<%-- Pagination --%>
<c:if test="${resultList.nrOfElements > 5}">
	<div class="row">
		<div class="col-md-8 col-sm-6 col-xs-6">
			<c:if test="${resultList.pageCount > 1}">
				<ul class="pagination">
					<%-- Previous button --%>
					<li<c:if test="${resultList.firstPage}"> class="disabled"</c:if>>
						<a href="
							<c:choose>
								<c:when test="${resultList.firstPage}">#</c:when>
								<c:when test="${! resultList.firstPage}"><s:url value="/staff/studentlist?page=${resultList.page-1}" /></c:when>
							</c:choose>
						">&laquo;</a>
					</li>
					
					<%-- First page and dots --%>
					<c:if test="${resultList.pageCount > 5 && resultList.page > 2}">
						<li><a href='<s:url value="/staff/studentlist?page=0" />'>1</a></li>
						<c:if test="${resultList.page != 3 && resultList.pageCount > 6}">
							<li class="disabled"><a href="#">...</a></li>
						</c:if>
					</c:if>
					
					<%-- Print numbers --%>
					<c:forEach begin="0" end="${resultList.pageCount-1}" varStatus="pageNumber">
						<c:if test="${
							pageNumber.index == resultList.page ||
							pageNumber.index == resultList.page - 1 ||
							pageNumber.index == resultList.page - 2 ||
							pageNumber.index == resultList.page + 1 ||
							pageNumber.index == resultList.page + 2 ||
							((resultList.page == 0 || resultList.page == 1) && pageNumber.index == resultList.page + 3) ||
							(resultList.page == 0 && pageNumber.index == resultList.page + 4) ||
							(resultList.page >= resultList.pageCount - 3 && pageNumber.index >= resultList.pageCount - 5)
						}">
							<li<c:if test="${resultList.page == pageNumber.index}"> class="active"</c:if>>
								<a href="<s:url value="/staff/studentlist?page=${pageNumber.index}" />">${pageNumber.index+1}</a>
							</li>
						</c:if>
					</c:forEach>
					
					<%-- Last page and dots --%>
					<c:if test="${resultList.page < resultList.pageCount - 3 &&	resultList.pageCount > 5}">
						<c:if test="${resultList.page != resultList.pageCount - 4 && resultList.pageCount > 6}">
							<li class="disabled"><a href="#">...</a></li>
						</c:if>
						<li><a href='<s:url value="/staff/studentlist?page=${resultList.pageCount-1}" />'>${resultList.pageCount}</a></li>
					</c:if>
					
					<%-- Next button --%>
					<li<c:if test="${resultList.lastPage}"> class="disabled"</c:if>>
						<a href="
							<c:choose>
								<c:when test="${resultList.lastPage}">#</c:when>
								<c:when test="${! resultList.lastPage}"><s:url value="/staff/studentlist?page=${resultList.page+1}" /></c:when>
							</c:choose>
						">&raquo;</a>
					</li>
				</ul>
			</c:if>
		</div>
		<div class="col-md-4 col-sm-6 col-xs-6 top20">
			<form class="form-horizontal" role="form">
				<div class="form-group">
					<label class="control-label col-xs-7" for="resultsPerPage">Results per page: </label>
					<div class="col-xs-4">
						<select class="form-control" id="resultsPerPage">
							<option<c:if test="${resultList.pageSize == 5}"> selected</c:if>>5</option>
							<option<c:if test="${resultList.pageSize == 10}"> selected</c:if>>10</option>
							<option<c:if test="${resultList.pageSize == 15}"> selected</c:if>>15</option>
							<option<c:if test="${resultList.pageSize == 20}"> selected</c:if>>20</option>
							<option<c:if test="${resultList.pageSize == 25}"> selected</c:if>>25</option>
							<option<c:if test="${resultList.pageSize == 30}"> selected</c:if>>30</option>
						</select>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<script>
		// Change page size after changing selection in #resultsPerPage drop down
		$(function() {
			$('#resultsPerPage').change(function(){
				var pageSize = $('#resultsPerPage').val();
				location.href = '<s:url value="/staff/studentlist?pageSize=" />' + pageSize;
			});
		});
	</script>
</c:if>
<%-- END Pagination --%>

<a href='<s:url value="/staff/studentcreate" />' class="btn btn-default">New Student User</a>