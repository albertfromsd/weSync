<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>   


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="/css/da_dashboard.css"> 
<title>Add New Task</title>
</head>
<body>
	<h4 style="color: green"><c:out value="${ success }"></c:out></h4>
	<h4 style="color: red"><c:out value="${ tagError }"></c:out></h4>
	<h1>New Task</h1>
	
	<form:form action="/new_question" method="post" modelAttribute="question">
		<p> <span style="color: red"><form:errors path="qText"/> </span></p>
		<p> <form:errors path="tags"/></p>
	    <p>
	        <form:label path="qText">Question:</form:label>
	        <form:input path="qText"/>
	    </p>
	    <p>
	        <label for="strTags">Tags (3 max; separate with ','):</label>
	        <input type="text" name="strTags"/>
	    </p>
	    <input type="submit" value="Create Question"/>
	</form:form>
	<br>
	<a href="/q_dashboard">Go to question dashboard</a><br>
<script type="text-javascript" src="/js/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script type="text-javascript" src="/js/dumbassassin.js"></script>
</body> 
</html>