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
	 $("#toggleprojectlist").click(function() {
		 console.log("Toggling between project logs")
		$('#currentprojects').toggleClass('hidden');
		$('#completedprojects').toggleClass('hidden');
		$('#toggleprojectlist').toggleClass( 'btn-outline-warning', 'btn-outline-success');

		var text = $('#toggleprojectlist').text();
		$('#toggleprojectlist').text(
			text == "View Current Projects" ? "View Completed Projects" : "View Current Projects");
    });

	$("#startnewproject").click(function() {
		console.log("Clicked start new project");
        $('.bg-modal').toggleClass('hidden');
	});

	$("#close").click(function() {
		console.log("Clicked close new project");
		$('.bg-modal').toggleClass('hidden');
	});
});
</script>
<meta charset="ISO-8859-1">
<title>DumbAssassin Dashboard</title>
</head>

<body>
	<div class="container-fluid">
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
		<h2 class="text-center">Project Dashboard</h2>
		<h6 class="text-center">
			<button class="btn btn-lg btn-outline-primary" id="startnewproject">Start a new project</button>
		</h6>
		
		<h4 style="color: green"><c:out value="${ success }"></c:out></h4>
	<div class="togglebuttonrow">
		<button class="btn btn-lg btn-outline-success" id="toggleprojectlist" style="margin-left: 15px;">View Completed Projects</button>
	</div>
		<table class="table table-border table-striped fixed-width" id="currentprojects">
		<caption class="text-center" style="font-size: 32px;">Current Projects</caption>
		<thead class="thead-dark">
			<tr class="text-center">
				<th width="10%">Public?</th>
				<th width="10%">Started</th>
				<th width="30%">Project name</th>
				<th width="10%">I/C Features</th>
				<th width="10%">Updated</th>
				<th width="15%">Action</th>
			</tr>
		</thead>
		<c:forEach items="${projects}" var="project">
			<c:if test="${project.completed == false}">
				<tr class="text-center box-top">
					<td>
						<c:if test="${project.shared == true}">
							Public<br>
							<form method="post" action="/projects/${project.id}/edit/shared" class="flex_colsb">
								<button class="btn btn-sm btn-outline-dark" name="shared" value="sharedFalse">Make Private</button>
							</form>
						</c:if>

						<c:if test="${project.shared == false}">
							Private<br>
							<form method="post" action="/projects/${project.id}/edit/shared" class="flex_colsb">
								<button class="btn btn-sm btn-outline-success" name="shared" value="sharedTrue">Make Public</button>
							</form>
						</c:if>

					</td>
					<td><br>${project.prettyCreatedAt()}</td>
					<td class="flex_col flex_center"><span style="font-size: 24px;"><a href="/projects/${project.id}">${project.projectName}</a></span></td>
					<td><br>${project.features.size()}</td>
					<td><br>${project.prettyUpdatedAt()}</td>
					<td>
					<div class="row flex_colcen">
						<form method="POST" action="/projects/${project.id}/completion" class="flex_colsb">
							<button class="btn btn-sm btn-outline-primary" name="completion" value="markComplete">Mark Complete</button>
						</form>
						<form method="get" action="/projects/${project.id}/delete">
							<button class="btn btn-sm btn-outline-danger">Delete Project</button>
						</form>
					</div>
					</td>
				</tr>
				<tr class="box-bottom">
					<td colspan="2" class="text-center bold"> Description: </td>
					<td colspan="4" class="text-left">
						<p>${project.description}</p>
					</td>
				</tr>
			</c:if>
		</c:forEach>
		</table>
		<table class="table table-striped fixed_width hidden" id="completedprojects">
		<caption class="text-center" style="font-size: 32px;">Completed Projects</caption>
		<thead class="thead-dark">
			<tr class="text-center">
				<th width="10%">Public?</th>
				<th width="10%">Started</th>
				<th width="30%">Project name</th>
				<th width="10%">I/C Features</th>
				<th width="10%">Updated</th>
				<th width="15%">Action</th>
			</tr>
		</thead>
		<c:forEach items="${projects}" var="project">
			<c:if test="${project.completed == true}">
				<tr class="text-center box_top">
					<td><br>
						<c:if test="${project.shared == true}">
							Public<br>
							<form method="post" action="/projects/${project.id}/edit/shared" class="flex_col flex_center">
								<button class="btn btn-sm btn-outline-dark" name="shared" value="sharedFalse">Make Private</button>
							</form>
						</c:if>

						<c:if test="${project.shared == false}">
							Private<br>
							<form method="post" action="/projects/${project.id}/edit/shared" class="flex_col flex_center">
								<button class="btn btn-sm btn-outline-primary" name="shared" value="sharedTrue">Make Public</button>
							</form>
						</c:if>
					</td>
					<td><br>${project.prettyCreatedAt()}</td>
					<td class="flex_col flex_center"><span style="font-size: 24px;"><a href="/projects/${project.id}"><br>${project.projectName}</a></span></td>
					<td><br>${project.features.size()}</td>
					<td><br>${project.prettyUpdatedAt()}</td>
					<td><br>
					<div class="row flex_colcen">
						<form method="POST" action="/projects/${project.id}/completion">
							<button class="btn btn-sm btn-outline-warning" name="completion" value="reopen">Reopen</button>
						</form>
						<form method="get" action="/projects/${project.id}/delete">
							<button class="btn btn-sm btn-outline-danger">Delete Project</button>
						</form>
					</div>
					</td>
				</tr>
				<tr class="box_bottom">
					<td colspan="2" class="text-center bold"><br>Description: </td>
					<td colspan="4" class="text-left">
						<p>${project.description}</p>
					</td>
				</tr>
			</c:if>
		</c:forEach>
		</table>

	</div>
	<!-- [END] entire_page container-fluid -->
	<div class="bg-modal hidden">
		<div id="newprojectmodal">
		<div id="close">+</div>
			<h4 style="color: green"><c:out value="${ success }"></c:out></h4>
			<h1 class="text-center">New Project Form</h1>
			<p> <span style="color: red"><form:errors path="project.*"/> </span></p>
			<div class="flex_colcen container-fluid">
				<form:form action="/createProject" method="post" modelAttribute="project" id="projectform">
				<div class="flex_row">
					<table class="full_width">
						<tr>
							<td> 
								<form:label path="projectName" class="dblock">Project Name:</form:label>
							</td>
							<td colspan="2">
								<form:input path="projectName" form="projectform" class="input_bar"/>
							</td>
						</tr>
						<tr>
							<td colspan="2" rowspan="5" class="flex_colcen">
								<form:label path="description">Description: </form:label>
							</td>
							<td colspan="2" rowspan="5">
								<form:textarea rows="5" path="description" form="projectform" class="projdesc-ta"/>
							</td>
						</tr>
					</table>
				</div>
				<br>
				<div class="radio_bar">
					<p>Make public?: </p>
					<form:radiobutton path="shared" value="true"/>Share
					<form:radiobutton path="shared" value="false"/>Keep private
				</div>
				<form:input type="hidden" path="completed" value="false"/>
				<br>
				<button class="btn btn-md btn-primary">Create Project</button>
				</form:form>
			</div>
			<!-- [END] div containing new project form -->
		</div>
		<!-- [END] modal content -->
	</div>
	<!-- [END] bg-modal -->

<script type="text-javascript" src="/js/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script type="text-javascript" src="/js/dumbassassin.js"></script>
</body>
</html>