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
			 $("#togglelogs").click(function() {
	                $('#activitylog').toggleClass('hidden');
	                $('#createtasktable').toggleClass('hidden');
	                $('#buglog').toggleClass('hidden');
	                $('#createbugtable').toggleClass('hidden');

	                var text = $('#togglelogs').text();
				    $('#togglelogs').text(
				        text == "View Bug Log" ? "View Activity Log" : "View Bug Log");
	         });

			 $("#edit").click(function() {
				$(".bg-modal").toggleClass("hidden");
			 });
			 $("#close").click(function() {
				$(".bg-modal").toggleClass("hidden");
			 });
				    
		});
	</script>
<meta charset="ISO-8859-1">
<title>Feature: <c:out value="${feature.featureName}"/></title>
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
	<div class="flex_row" style="padding: 0px;">
		<div class="headercol flex_col" style="overflow:overlay;">
			<a href="/projects/${project.id}"><p class="text-center header_text"><c:out value="${ project.projectName}"/></a>:: <c:out value="${ feature.featureName }"/></p>
			<div class="flex_row">

				<button class="btn btn-sm btn-outline-warning" id="edit">Edit Feature</button>

				<c:if test ="${feature.completed == true }">
					<form method="post" action="/projects/${project.id}/features/${feature.id}/completion" class="flex_col flex_center">
						<button class="btn btn-sm btn-outline-warning" name="completion" value="editReopen">Reopen</button>
					</form>
				</c:if>
				<c:if test ="${feature.completed == false }">
					<form method="post" action="/projects/${project.id}/features/${feature.id}/completion" class="flex_col flex_center">
						<button class="btn btn-sm btn-outline-primary" name="completion" value="editMarkComplete">Mark Complete</button>
					</form>
				</c:if>
			</div>
			<div class='flex_row'>
				<form:form method="delete" action="/projects/${project.id}/features/${feature.id}">
					<button class="btn btn-outline-danger btn-sm" id="delete">Delete Feature</button>
				</form:form>
			</div>
		</div>
		<div class="headerbtnbox flexcolsb">
			<br>
			<p style="color:green" class="text-center"><c:out value="${success}"/></p>
			<button class="btn btn-outline-warning" id="togglelogs">View Bug Log</button>
		</div>
	</div>
	
<!-- end of header row -->
	
	<div class="row">
		<!-- [TOP] FEATURES column -->
		<div class="col-md-3 box-border">
			<!-- [TOP] unfinished features column -->
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
			<!-- [END] of unfinished features -->
			<!-- [TOP] completed features column -->
			<div>
				<br>
				<p>Completed:</p> 
				<table class="full_width fixed_width">
					<c:forEach items="${project.features}" var="feature">
						<c:if test="${feature.completed == true }">
							<tr class="feature_row">
								<td class="text-left feature_label"><a href="/projects/${project.id}/features/${feature.id}"><c:out value="${feature.featureName}"/></td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>
			<!-- [END] of finished features -->
		</div>
		<!-- [END] of both FEATURES column -->
		<div class="col-md-9 box-border">
			<!-- [TOP] HIDDEN: DESCRIPTION row -->
			<div class="row hidden">
				<div class="col-sm text-center box-border">
					<div class="name_formbox flex_colcen">
						<form method="post" action="/features/${feature.id}/edit/featurename">
							<input type="text" name="featurename" value="${feature.featureName}" class="input_bar" style="margin-top: -10px">
							<button class="btn btn-sm btn-outline-secondary" style="margin-top: 15px;">Edit Feature Name</button>
						</form>
					</div>
					<p class="text-left">Users: </p>
					<ul class="ul_tighten" style="list-style-type:none">
						<c:forEach items="${project.users}" var="users">
							<li class="li_tighten">${user.username}</li>
						</c:forEach>
					</ul>
				</div> 
				<div class="col-sm box-border flex_col flex_center">
					<p class="header_text text-center">Feature description: </p>
					<div class = "form_div">
					<form method="post" action="/features/${feature.id}/edit/description" id="description_form">
						<textarea name="description" form="description_form" class="desc_textarea"><c:out value="${feature.description}"/></textarea>
						<div class="flex_row">
							<button class="btn btn-sm btn-outline-secondary button_row">Change description</button>
						</div>
					</form>
					</div>
				</div>
		<!-- 		end of description col-sm -->
				<div class="col-sm flex_row box-border">
					<table>
						<tr>
							<th class="text-right">Created at:</th>
							<td class="text-center"><c:out value="${feature.createdAt}"/></td>
						</tr>
						<tr>
							<th class="text-right">Updated at:</th>
							<td class="text-center"><c:out value="${feature.updatedAt}"/></td>
						</tr>
						<tr>
							<th class="text-right">Shared?: <br> 
								<c:if test ="${feature.shared == true }">
									Public
								</c:if>
								<c:if test ="${feature.shared == false }">
									Private
								</c:if>
							</th>
							<td class="text-center">
								<c:if test ="${feature.shared == true }">
									<form method="post" action="/features/${feature.id}/edit/shared" class="flex_col flex_center">
										<button class="btn btn-sm btn-outline-dark" name="shared" value="editSharedFalse">Make Private</button>
									</form>
								</c:if>
								<c:if test ="${feature.shared == false }">
									<form method="post" action="/features/${feature.id}/edit/shared" class="flex_col flex_center">
										<button class="btn btn-sm btn-outline-success" name="shared" value="editSharedTrue">Make Public</button>
									</form>
								</c:if>
							</td>
						</tr>
						<tr>
							<th class="text-right">Completion:<br>
								<c:if test ="${feature.completed == true }">
									Completed
								</c:if>
								<c:if test ="${feature.completed == false }">
									In Progress
								</c:if>
							</th>
							<td class="text-center">
								<c:if test ="${feature.completed == true }">
									<form method="post" action="/features/${feature.id}/completion" class="flex_col flex_center">
										<button class="btn btn-sm btn-outline-warning" name="completion" value="editReopen">Reopen</button>
									</form>
								</c:if>
								<c:if test ="${feature.completed == false }">
									<form method="post" action="/features/${feature.id}/completion" class="flex_col flex_center">
										<button class="btn btn-sm btn-outline-primary" name="completion" value="editMarkComplete">Mark Complete</button>
									</form>
								</c:if>
							</td>
						</tr>
					</table>
				</div>
				<!-- end of shared/completion column -->
			</div>
			<!-- [END] HIDDEN: DESCRIPTION row -->
			<p><c:out value="${errorMsg}"/></p>
			<table class="table table-border" id="createtasktable">

				<tr class="box-border">
					<form method="post" action="/projects/${project.id}/features/${feature.id}/createtask" id="createtaskform">
					<td>
						<textarea name="description" form="createtaskform" class="celltextarea" placeholder="Description of new task"></textarea>
					</td>
					<td>
						<textarea name="notes" form="createtaskform" class="celltextarea" placeholder="Notes / Questions / Issues"></textarea>
					</td>
					<td>
						<input type="text" name="subjectFiles" form="createtaskform" class="cellinputbar" placeholder="filename.xxx">
					</td>
					<input type="hidden" name="feature" value="${feature.id}"/>
					<td class="centerall">
						<button class="btn btn-sm btn-outline-success" form="createtaskform">Add Task</button>

					</td>
					</form>
				</tr>
			</table>
				<!-- [TOP] ACTIVITY LOG -->
			<table class="table table-border" id="activitylog">
				<thead class="thead-dark">
					<tr>
						<th colspan="7" class="text-center">Activity Log </th>
					</tr>
				</thead>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<c:forEach items="${tasks}" var="t"> 
					<tr class="box-top">
						<td colspan="1" class="text-right">Description:
						<td colspan="4" class="text-justify td-border">
							${t.description}
						</td>
						<td class="text-center td-border ">
							${t.subjectFiles}
						</td>
						<td colspan="2" class="text-center td-border">
							${t.prettyCreatedAt()}
						</td>		
					</tr>
					<tr class="box-side">
						<td colspan="4" class="underline">Related notes/questions below</td>
						<td>
							<form>
								<button class="btn btn-sm btn-outline-info">Details</button>
							</form>
						</td>
						<td>
							<form>
								<button class="btn btn-sm btn-outline-warning">Edit</button>
							</form>
						</td>
						
						<td>
							<form>
								<button class="btn btn-sm btn-outline-danger">Delete</button>
							</form>
						</td>
					</tr>
					<tr class="box-bottom">
						<td colspan="7" class="td-border">${t.notes}</td>
					</tr>
					<tr class="box-bottom">
						<td>  </td>
						<td>  </td>
						<td>  </td>
						<td>  </td>
						<td>  </td>
						<td>  </td>
						<td>  </td>
					</tr>
				</c:forEach>
			</table>
			<!-- [END] ACTIVITY LOG -->
			<table class="table table-border hidden" id="createbugtable">
				<tr class="box-border">
					<form method="post" action="/projects/${project.id}/features/${feature.id}/createbug" id="createbugform"></form>
					<td class="centerall">
						<button class="btn btn-sm btn-outline-success" form="createbugform">Add Bug</button></td>
					<td>
						<textarea name="bugDesc" form="createbugform" class="celltextarea" placeholder="Description of bug"></textarea>
					</td>
					<td>
						<textarea name="notes" form="createbugform" class="celltextarea" placeholder="Notes / Questions / Issues"></textarea>
					</td>
					<td>
						<textarea name="errorMsg" form="createbugform" class="celltextarea" placeholder="Copy main error message here"></textarea>
					</td>
					<input type="hidden" name="feature" value="${feature.id}"/>
					</form>
				</tr>
			</table>
			<table class="table table-border hidden" id="buglog">
				<thead class="thead-dark">
					<tr>
						<th class="text-center" colspan="5">Bug Log</th>
					</tr>
				</thead>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<c:forEach items="${feature.bugs}" var="bug">
				<tr class="box-top">
					<td colspan="3">Bug: ${bug.bugDesc}</td>
					<td colspan="2">${bug.prettyCreatedAt()}</td>
				</tr>
				<tr class="box-bottom">
					<td colspan="3">Notes: ${bug.notes}</td>
					<td colspan="2">Error Message: ${bug.errorMsg}</td>
				</tr>
				<tr>
					<td>  </td>
					<td>  </td>
					<td>  </td>
					<td>  </td>
					<td>  </td>
				</tr>
				</c:forEach> 
			</table>
		</div>
		<!-- end of second main larger column -->
		
	</div>
 	<!-- end of entire page row -->
</div>
	<!-- end of main content row -->
<!-- end of entire page container-fluid -->
<div class="bg-modal hidden">
	<div id="editfeaturemodal">
	<div id="close">+</div>
		<h4 style="color: green"><c:out value="${ success }"></c:out></h4>
		<h1 class="text-center">Edit Feature Form</h1>
		<p> <span style="color: red"><form:errors path="feature.*"/> </span></p>
		<div class="flex_row">
			<div class="flex_colcen container-fluid">
				<form:form action="/projects/${project.id}/features/${feature.id}/editFeature" method="post" modelAttribute="feature" id="editfeatureform">
				<div class="flex_row">
					<table class="full_width">
						<tr>
							<td> 
								<form:label path="featureName" class="dblock modal_label text-left">Feature Name:</form:label>
							</td>
							<td>
								<form:input path="featureName" colspan="3" form="editfeatureform" class="modal_input_bar" value="${feature.featureName}"/>
							</td>
							<td> </td>
						</tr>
						<tr>
							<td colspan="1" class="flex_colcen">
								<form:label path="description" class="modal_label">Description: </form:label>
							</td>
							<td colspan="3">
								<form:textarea rows="5" path="description" form="editfeatureform" class="projdesc-ta" value="${feature.description}"/>
							</td>
						</tr>
						<tr>
							<td class="flex_colcen">
								<form:label path="notes" class="modal_label">Notes: </form:label>
							</td>
							<td colspan="3">
								<form:textarea rows="5" path="notes" form="editfeatureform" class="projdesc-ta" value="${feature.notes}"/>
							</td>
						</tr>
						<tr>
							<td> 
								<form:label path="subjectFiles" class="dblock modal_label">Subject File(s):</form:label>
							</td>
							<td colspan="3">
								<form:input path="subjectFiles" form="editfeatureform" class="modal_input_bar" value="${feature.subjectFiles}"/>
							</td>
						</tr>
						<tr>
							<td> 
								<form:label path="priority" class="modal_label">Priority: </form:label>
							</td>
							<td colspan="1">
								<form:input path="priority" type="number" class="modal_input_num" value="${feature.priority}"></form:input>
							</td>
						</tr>
						<br>
						<tr>
							<td class="text-left">
								<form:label path="shared" class="modal_label">Make public?:</form:label>
							</td>
							<td class="text-left">
								<form:radiobutton path="shared" value="true"/>Share<br>
								<form:radiobutton path="shared" value="false"/>Keep private
							</td>
							<td>
								<form:input type="hidden" path="completed" value="false"/>
								<br>
								<button class="btn btn-md btn-primary bottom-right">Submit Changes</button>
								</form:form>	
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- [END] flex colcen container-fluid inside form -->
			
			<!-- [END] radio bar for shared status -->
			
		</div>
		<!-- [END] flex row containing new project form -->
	</div>
	<!-- [END] edit feature modal -->
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