<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>   


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="/css/da_dashboard.css">  
<script type="text/javascript" src='http://code.jquery.com/jquery-1.10.2.min.js'></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#viewall").click(function() {
	                $('#projectresults').show();
	                $('#featureresults').show();
	                $('#taskresults').show();
	                $('#bugresults').show();
	         });

			 $("#viewprojects").click(function() {
	                $('#projectresults').show();
	                $('#featureresults').hide();
	                $('#taskresults').hide();
	                $('#bugresults').hide();
	         });

			 $("#viewfeatures").click(function() {
	                $('#projectresults').hide();
	                $('#featureresults').show();
	                $('#taskresults').hide();
	                $('#bugresults').hide();
	         });

			 $("#viewtasks").click(function() {
	                $('#projectresults').hide();
	                $('#featureresults').hide();
	                $('#taskresults').show();
	                $('#bugresults').hide();
	         });

			 $("#viewbugs").click(function() {
	                $('#projectresults').hide();
	                $('#featureresults').hide();
	                $('#taskresults').hide();
	                $('#bugresults').show();
	         });
				    
			 
		});
	</script>
<meta charset="ISO-8859-1">
<title>Search Databases</title>
</head>

<body>
	<div class="entire_page container-fluid">
		<nav class="navbar navbar-expand navbar-dark bg-dark md-light container-fluid mynavbar">
			<a class="navbar-brand" href="#"></a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
			</button>
	
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav nav_ul">
					<li class="nav-item">
						<form action='/dashboard' method='get'>
							<input type='hidden' name='dashboard' value="${user.id}">
							<button type='submit'class="nav-link bg-dark md-light">Dashboard</button>
						</form>
					</li>
					<li class="nav-item dropdown nav_li">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							Project Menu
						</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item">
							<form action="/newProject">
								<button class="btn-block">New Project</button>
							</form>
						</a>
					<div class="dropdown-divider"></div>
						<a class="dropdown-item">
						<form action="/entervaluehere">
							<button type="entervaluehere" class="btn-block">Project Button</button>
						</form>
						</a>
					</li>
					<li class="nav-item dropdown nav_li">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							Feature Menu
						</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item">
							<form action="/newProject">
								<button class="btn-block">New Feature</button>
							</form>
						</a>
					<div class="dropdown-divider"></div>
						<a class="dropdown-item">
						<form action="/entervaluehere">
							<button type="entervaluehere" class="btn-block">Feature Button</button>
						</form>
						</a>
					</li>
					<li class="nav-item">
						<form action='/search' method='get'>
							<button type='submit'class="nav-link bg-dark md-light">Search</button>
						</form>
					</li>
					<li class="nav-item">
						<a class="nav-link disabled" href="#" class="text-center"><c:out value="${user.username}"/><br>Open Projects: <c:out value="${ user.projects.size() }"/></a>
					</li>
					<li class="nav-item">
						<form action="/logout" method="get">
							<button class="nav-link bg-dark md-light">Logout</button>
						</form>
					</li>
	
				</ul>
			</div>
		</nav>
        <br>
		<h2 class="text-center">Search Databases</h2>
		<div class="search_box">
			<form method="post" action="/search">
				<input type="text" name="search" class="search_input_bar" placeholder="Enter search text here">
				<div class="centerall">
					<button class="btn btn-sm btn-primary">Search</button>
				</div>
			</form>
		</div>
	<div class="searchresultsbuttons">
		<c:if test="${srcProjects.size() + srcFeatures.size() + srcTasks.size() + srcBugs.size() > 0}">
			<button class="btn btn-sm btn-info" id="viewall">All results (<c:out value="${srcProjects.size() + srcFeatures.size() + srcTasks.size() + srcBugs.size()}"/>)</button>
		</c:if>
		<c:if test="${srcProjects.size() > 0}">
			<button class="btn btn-sm btn-primary" id="viewprojects" style="margin-left: 15px">Project Results (<c:out value="${srcProjects.size()} "/>)</button>
		</c:if>
		<c:if test="${srcFeatures.size() > 0}">
			<button class="btn btn-sm btn-success" id="viewfeatures" style="margin-left: 15px">Feature Results ( <c:out value="${srcFeatures.size()} "/>)</button>
		</c:if>
		<c:if test="${srcTasks.size() > 0}">
			<button class="btn btn-sm btn-info" id="viewtasks" style="margin-left: 15px">Task Results ( <c:out value="${srcTasks.size()} "/>)</button>
		</c:if>
		<c:if test="${srcBugs.size() > 0}">
			<button class="btn btn-sm btn-warning" id="viewbugs" style="margin-left: 15px">Bug Results ( <c:out value="${srcBugs.size()}"/>)</button>
		</c:if>
	</div>
	<c:if test="${srcProjects.size() > 0}">
		<table class="table table-border" id="projectresults">
		<caption>Project search results</caption>
		<thead class="thead-dark">
			<tr class="text-center">
				<th>Project name</th>
				<th>I/C?</th>
				<th>Updated</th>
			</tr>
		</thead>
		<c:forEach items="${srcProjects}" var="project">
			<tr class="box-top"> 
				<td class="text-center"><a href="/projects/${project.id}">${project.projectName}</a></td>
				<td class="text-center">
					<c:if test="${project.completed == true}">
						Complete
					</c:if>
					<c:if test="${project.completed == false}">
						In Progress
					</c:if>
				</td>
				<td class="text-center">${project.prettyUpdatedAt()}</td>
			</tr>
			<tr class="box-bottom">
				<td class="text-right"> Project Description: </td>
				<td class="text-left" colspan="2">${project.description}</td>
			</tr>
			<tr><td> </td> <td> </td> <td> </td></tr>
		</c:forEach>
		</table>
	</c:if>
	<!-- [END] Project search resuts -->
	<!-- [TOP] Feature search results -->
	<c:if test="${srcFeatures.size() > 0}">
		<table class="table table-border" id="featureresults">
			<caption>Feature search results</caption>
			<thead class="thead-dark">
				<tr class="text-center">
	<!-- 				<th>Project:<th> -->
					<th>Feature name</th>
					<th>I/C?</th>
					<th>Updated</th>
				</tr>
			</thead>
			<c:forEach items="${srcFeatures}" var="feature">
				<tr class="box-top"> 
					<td class="text-center"><a href="/projects/${feature.project.id}/features/${feature.id}">${feature.featureName}</a></td>
					<td class="text-center">
						<c:if test="${feature.completed == true}">
							Complete
						</c:if>
						<c:if test="${feature.completed == false}">
							In Progress
						</c:if>
					</td>
					<td class="text-center">${feature.prettyUpdatedAt()}</td>
				</tr>
				<tr class="box-bottom">
					<td class="text-right"> Feature Description: </td>
					<td class="text-left" colspan="2">${feature.description}</td>
				</tr>
				<tr><td> </td> <td> </td> <td> </td></tr>
			</c:forEach>
		</table>
	</c:if>
	<!-- [END] FEATURE Search results -->
		
	<!-- [TOP] TASK Search results -->
	<c:if test="${srcTasks.size() > 0}">
		<table class="table table-border" id="taskresults">
			<caption>Task search results</caption>
			<thead class="thead-dark">
				<tr class="text-center">
					<th colspan="5">Tasks</th>
				</tr>
			</thead>

		<c:forEach items="${srcTasks}" var="task">
			<tr class="box-top">
	<!-- 				<th>Project:</th> -->
				<td class="text-center">Feature ID: ${task.feature.id}</td>
				<td class="text-right" colspan="1">Created: </td>
				<td class="text-left" colspan="2">${task.prettyCreatedAt()}</td>
	<!-- 			<td class="text-right"># of Bugs: </td>	 -->
	<%-- 			<td class="text-center"> <c:out value="${task.bugs.size()}"/></td>		 --%>
			</tr>
			<tr class="box-top"> 
	<%-- 				<td class="text-center"><a href="/projects/${feature.project.id}">${feature.project.projectName}</a></td> --%>
				<td class="text-right" colspan="1"><a href="/projects/${feature.project.id}/features/${feature.id}">Task Description:</a></td>
				<td class="text-left" colspan="3">${task.description}</td>
			<tr class="box-bottom">
				<td class="text-right" colspan="1">Task Notes:</td>
				<td class="text-left" colspan="3" style="overflow:auto">${task.notes}</td>
			</tr>
			<tr><td> </td> <td> </td> <td> </td></tr>
		</c:forEach>
		</table>
	</c:if>
	<!-- [END] TASK Search Results -->
<!-- 	[TOP] BUG Search Results -->
	<c:if test="${srcBugs.size() > 0}">
		<table class="table table-border" id="bugresults">
			<caption>Bug search results</caption>
			<thead class="thead-dark">
			<tr>
				<th colspan="4" class="text-center"> Bugs</th>
			</tr>
			</thead>
			<c:forEach items="${srcBugs}" var="bug">
				<tr class="box-top"> 
	<!-- 			<th>Project:<th> -->
					<td>Feature ID: ${bug.feature.id}</td>
					<td class="text-right">Created: </td>
					<td class="text-left">${bug.prettyCreatedAt()}</td>
					<td>Updated</td>
				</tr>
				<tr class="box-sides">
	<%-- 				<td class="text-center"><a href="/projects/${feature.project.id}">${feature.project.projectName}</a></td> --%>
					<td class="text-right" colspan="1">Bug Description: </td>
					<td class="text-left" colspan="3">${bugDesc}</td>
				</tr>
				<tr class="box-bottom">
					<td class="text-center" colspan="1"> Bug Error Message: </td>
					<td class="text-left" colspan="3">${bug.errorMsg}</td>
				</tr>
				<tr><td> </td> <td> </td> <td> </td></tr>
			</c:forEach>
		</table>
	</c:if>
<!-- 	{END} BUG Search Results -->
	

		
	</div>
<script type="text-javascript" src="/js/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script type="text-javascript" src="/js/dumbassassin.js"></script>
</body>
</html>