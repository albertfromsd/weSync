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
<title>Edit </title>
</head>
<body>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-8">
			<h1 class="text-center">Edit <c:out value="${ project.projectName }"></c:out></h1>
			<h6><span style="color:red"><c:out value="${error }"/></span></h6>
		</div>
		<div class="col-md-4">
			<h5 class="text-right"><a href="/dashboard">Go to dashboard</a><br></h5>
			<br>
			<h5 class="text-right"><a href="logout">Logout</a><br></h5>
		</div>
	</div>
<!-- end of header row -->
	<div class="row">
		<div class="col-sm">
			<p>Currently: 
			<c:if test="${ project.completed == true}">
					Public
				</c:if>
				<c:if test="${ project.completed == false}">
					Private
				</c:if>
			<form method="post" action="/projects/${project.id}/edit/shared">
			    <div class="radio_box">
		            <label class="radio_bar">
		                <input type="radio" name="shared" value="true">Public
		            </label>
		            <label class="radio_bar">
		                <input type="radio" name="shared" value="false">Private
		            </label>
	            </div>
	            <button class="btn btn-sm btn-outline-warning">Change shared status</button>
		    </form>
		</div>
		<div class="col-sm">
			<p>Status: 
				<c:if test="${ project.completed == false}">
					In Progress
				</c:if>
				<c:if test="${ project.completed == true}">
					Completed
				</c:if>
			<form method="post" action="/projects/${project.id}/edit/completed">
			    <div class="radio_box">
		            <label class="radio_bar">
		                <input type="radio" name="completed" value="false">In progress
		            </label>
		            <label class="radio_bar">
		                <input type="radio" name="completed" value="true">Completed
		            </label>
	            </div>
	            <button class="btn btn-sm btn-outline-warning">Changedcompletion status</button>
		    </form>
		</div>
	
	</div>
	<div class="row">
		<div class="col-md-4">
			<h4 class="text-right">Description: </h4>
		</div>
		<div class>
			<form method="post" action="/projects/${project.id}/edit/description" id="description_form">
				<label for="description" class="text-top">Enter new description:</label>
				<textarea name="description" form="description_form"><c:out value="${project.description}"/></textarea>
				<div class="row">
					<button class="btn btn-sm btn-outline-warning">Change description</button>
				</div>
			</form>
		</div>
	</div>
	
	
	<div class="row">
		<div class="col-sm">
		
		</div>
		<div class="col-sm text-center box-border">

		</div> 
<!-- 		end of first col-sm -->
		<div class="col-sm flex_row box-border">
			<div class="text-right">

			</div>
<!-- 			end of label column -->
			<div class="text-left">

			</div>
<!-- 			end of value column -->
		</div>
<!-- 		end of second column -->
		<div class="col-sm">
		
		</div>
	</div>
<!-- 	end of createdAt, updatedAt, public/private row -->

<!-- 	end of description row -->
	<div class="row flex_row">
		<div class="new_feature_form">
		
		</div>
	</div>
	<div class="row">
		<div class="col-sm">
		
		</div>
		<div class="col-sm  box-border">

		</div>
<!-- 	end of unfinished features row -->
		<div class="col-sm box-border">

		</div>
<!-- 		end of completed features column -->
		<div class="col-sm">
		
		</div>
	</div>
<!-- 	end of features row -->
</div>
<!-- end of container-fluid -->

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

</body> 
</html>