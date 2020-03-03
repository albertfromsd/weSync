<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="/css/da_dashboard.css">
<script type="text/javascript" src='http://code.jquery.com/jquery-1.10.2.min.js'></script>
	<script type="text/javascript">
		$(document).ready(function() {
			 $("#toregister").click(function() {
	            $('.bg-modal').toggleClass('hidden');
			 });
			 
			 $('#close').click(function() {
				$('.bg-modal').toggleClass('hidden');
			 });
				    
		});
	</script>


<meta charset="UTF-8">
<title>Welcome to DumbAssassin</title>
</head>
<body>
<div class="container-fluid">
	<div class="flex_colcen">
    <h1 class="text-center">Welcome to DumbAssassin!</h1>
		<h1>Login</h1>
		
			<p><span style="color: red"><c:out value="${error}" /></span></p>
			<form method="post" action="/login">
			<div class="flex_row">
				<div class="reg_label_column flex-col">
					<label for="username">User name:</label>
					<br>
					<label for="password">Password:</label>
				</div>
				<div class="input_column flex_col">
					<input type="text" id="username" name="username"/>
					<br>
					<input type="password" id="password" name="password"/>
				</div>
			</div>
			<div class="flex_row">
				<button class="btn btn-sm btn-primary">Login</button>
			</div>
			</form>
			<div class="flex_row" id="toregister">
				<button class="btn btn-sm btn-outline-primary">Register</button>
			</div>
	    
    <a href="/logout">Logout (clear session)</a>
	</div>
<div class="bg-modal hidden">
	<div class="modal-content">
		<div id="close"> + </div>
		<h4 class="text-center">Register below</h4>
		<p><form:errors path="user.*"/></p>
		<form:form method="POST" action="/register" modelAttribute="user">
		<div class="flex_row">
			<div class="reg_label_column flex_col jc-end">
				<form:label path="username">Username:</form:label>
				<form:label path="email">Email:</form:label>
				<form:label path="password">Password:</form:label>
				<form:label path="confirmPw">Confirm:</form:label>
			</div>
			<div class="input_column flex_col">
				<form:input type="text" path="username" class="input_bar"/>
				<br>
				<form:input type="text" path="email" class="input_bar"/>
				<br>
				<form:password path="password" class="input_bar"/>
				<br>
				<form:password path="confirmPw" class="input_bar"/>
			</div>
		</div>
		<br>
		<button class="btn btn-outline-primary btn-md">Register</button>
		</form:form>
	</div>
	<!-- [END] modal-content -->
</div>
<!-- [END] bg-modal -->
</div>
<!-- [END] container -->

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>