<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>   


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="/css/da_dashboard.css">   
<meta charset="ISO-8859-1">
<title>Delete Item</title>
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
	<h2 class="text-center"> Confirm Deletion</h2>
	<p class="text-center" style="color: red">Are you sure you want to delete this project?</p>
	<p class="text-center" style="color: red">All associated features/tasks will also be deleted</p>
		
	<h4 class="text-center">Project name: <c:out value="${ project.projectName }"/></h4>
	<h6 class="text-center">Created: <c:out value="${ project.createdAt }"/></h6>
	

	
	<div class="flex_row">	
		<form:form method="delete" action="/projects/${project.id}/delete">
			<button class="btn btn-md btn-outline-danger">Yes, DELETE project</button>
		</form:form>
	</div>
	
	<div class="col-sm text-center box-border">
		<p>Users: </p>
		<c:forEach items="${project.users}" var="users">
			<p>${user.username}</p><br>
		</c:forEach>
	</div> 
	<br>
	<p>Unfinished features: </p>
	<div class="box_border">
		<c:forEach items="${project.features}" var="feature">
		<ul>
			<c:if test="${feature.completed == false}">
				<li>${feature.featureName}</li>
			</c:if>
		</ul>
		</c:forEach>
	</div>
<!-- 	end of unfinished features row -->
	<div class="box_border">
		<p>Completed features:</p> 
		<c:forEach items="${project.features}" var="feature">
		<ul>
			<c:if test="${feature.completed == true }">
				<li>${feature.featureName}</li>
			</c:if>
		</ul>
		</c:forEach>
	</div>
	
	
</div>
<!-- end of container-fluid -->

<script type="text-javascript" src="/js/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script type="text-javascript" src="/js/dumbassassin.js"></script>

</body> 
</html>