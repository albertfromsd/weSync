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
<title>Proj: <c:out value="${ project.projectName }"/></title>
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
		<h2 class="text-center" style="margin-bottom: -10px">Project Overview: </h2>
		<h3 class="text-center"><c:out value="${ project.projectName }"/> </h3>
<!-- end of header row -->
	
	<div class="row">
		<div class="col-md-2 box-border">
			<div>
				<table class="full_width">
					<p>In progress</p>
					<thead style="border-bottom: 1px solid black;">
						<th class="text-center">Priority</th>
						<th class="text-center">Feature Name </th>
					</thead>
					<c:forEach items="${descFeatures}" var="feature">
						<c:if test="${feature.completed == false }">
							<tr class="feature_row" style="border-bottom: 1px dotted black;">
								<td class="text-center" style="border-right: 1px dotted black;">${feature.priority}</td>
								<td class="text-left feature_label"><a href="/projects/${project.id}/features/${feature.id}"><c:out value="${feature.featureName}"/></td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>
			<!-- end of unfinished features -->
			<div>
				<p>Completed features:</p> 
				<c:forEach items="${project.features}" var="feature">
				<ul class="ul_tighten">
					<c:if test="${feature.completed == true }">
						<li class="li_tighten"  style="border-bottom: 1px dotted black;"><a href="/projects/${project.id}/features/${feature.id}"><c:out value="${feature.featureName}"/></a></li>
					</c:if>
				</ul>
				</c:forEach>
			</div>
			<!-- end of finished features -->
		</div>
		<!-- end of both features column -->
		<div class="col-md-10">
			<div class="row">
				<div class="col-sm text-center box-border">
					<div class="name_formbox flex_colcen">
						<br>
						<form method="post" action="/projects/${project.id}/edit/projectname">
							<input type="text" name="projectname" value="${project.projectName}" class="input_bar text-center" style="margin-top: -10px">
							<button class="btn btn-sm btn-outline-secondary" style="margin-top: 15px;">Edit Project Name</button>
						</form>
						<br>
					</div>
					<p class="text-left">Users: </p>
					<ul class="ul_tighten" style="list-style-type:none">
						<c:forEach items="${project.users}" var="users">
							<li class="li_tighten">${user.username}</li>
						</c:forEach>
					</ul>
				</div> 
				<div class="col-sm box-border flex_col flex_center">
					<p class="header_text text-center">Description: </p>
					<div class = "form_div">
					<form method="post" action="/projects/${project.id}/edit/description" id="description_form">
						<textarea name="description" form="description_form" class="desc_textarea text-justify"><c:out value="${project.description}"/></textarea><br>
						<div class="flex_row">
							<button class="btn btn-sm btn-outline-secondary button_row">Change description</button>
						</div>
					</form>
					<br>
					</div>
				</div>
		<!-- 		end of description col-sm -->
				<div class="col-sm flex_row box-border">
					<table>
						<tr>
							<th class="text-right">Created:</th>
							<td class="text-center"><c:out value="${project.prettyCreatedAt()}"/></td>
						</tr>
						<tr>
							<th class="text-right">Updated:</th>
							<td class="text-center"><c:out value="${project.prettyUpdatedAt()}"/></td>
						</tr>
						<tr>
							<th class="text-right">Shared?: <br> 
								<c:if test ="${project.shared == true }">
									Public
								</c:if>
								<c:if test ="${project.shared == false }">
									Private
								</c:if>
							</th>
							<td class="text-center">
								<c:if test ="${project.shared == true }">
									<form method="post" action="/projects/${project.id}/edit/shared" class="flex_col flex_center">
										<button class="btn btn-sm btn-outline-dark" name="shared" value="editSharedFalse">Make Private</button>
									</form>
								</c:if>
								<c:if test ="${project.shared == false }">
									<form method="post" action="/projects/${project.id}/edit/shared" class="flex_col flex_center">
										<button class="btn btn-sm btn-outline-success" name="shared" value="editSharedTrue">Make Public</button>
									</form>
								</c:if>
							</td>
						</tr>
						<tr>
							<th class="text-right">Completion:<br>
								<c:if test ="${project.completed == true }">
									Completed
								</c:if>
								<c:if test ="${project.completed == false }">
									In Progress
								</c:if>
							</th>
							<td class="text-center">
								<c:if test ="${project.completed == true }">
									<form method="post" action="/projects/${project.id}/completion" class="flex_col flex_center">
										<button class="btn btn-sm btn-outline-warning" name="completion" value="editReopen">Reopen</button>
									</form>
								</c:if>
								<c:if test ="${project.completed == false }">
									<form method="post" action="/projects/${project.id}/completion" class="flex_col flex_center">
										<button class="btn btn-sm btn-outline-primary" name="completion" value="editMarkComplete">Mark Complete</button>
									</form>
								</c:if>
							</td>
						</tr>
					</table>
				</div>
				<!-- end of shared/completion column -->
			</div>
			<!-- end of top description row -->
			<div class="row">
				<div class=" col-sm new_feature_form">
					<h5 class="text-center box-border">Add feature to this project</h5>
					<p class="error_msg"><form:errors path="feature.*"/></p>
					<form:form action="/projects/${project.id}/createFeature" method="post" modelAttribute="feature" id="featureform">
						<!-- [top] top row with feature name input -->
						<div class="flex_row form_row">
							<form:label path="featureName" class="label_column text-right">Feature/Task name: </form:label>
							<form:input type="text" path="featureName" class="input_bar input_column"></form:input>
						</div>
						<div class="flex_row form_row">
							<form:label path="priority" class="label_column text-right">Priority level: <br> (Higher # for higher priority)</form:label>
							<form:input type="number" path="priority" class="input_number input_column"></form:input>
						</div>
						<!-- [end] feature name input -->
						<div class="flex_row form_row">
							<form:label path="description" class="label_column text-right">Description: </form:label>
							<textarea name="description" form="featureform" class="input_textarea text-justify"></textarea>
						</div>
						<div class="flex_row form_row">
							<form:label path="notes" class="label_column text-right">Notes/Questions/Issues: </form:label>
							<textarea name="notes" form="featureform" class="input_textarea text-justify"></textarea>
						</div>
							<form:input type="hidden" path="completed" value="false"/>
						<div class="radio_bar flex_row">
							<p>Make public?:     
							<form:radiobutton path="shared" value="true"/>Share
							<form:radiobutton path="shared" value="false"/>Keep private   
							</p>
						</div>
						<!-- end of input fields of form, button below along with form end -->
						<div class="flex_row">
							<form:button class="btn btn-outline-primary">Add feature this project</form:button>
						</div>
					</form:form>
				</div>
				<!-- end of create new feature form -->

		</div>
		<!-- end of second main larger column -->
		
	</div>
 	<!-- end of entire page row -->
	</div>
	<!-- end of main content row -->
	
</div>
<!-- end of entire page container-fluid -->

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

</body> 
</html>