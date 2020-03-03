<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>   


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/dojosurvey.css">
<title>Feature Details</title>
</head>
<body>
	<h1>Feature Details</h1>
	<h4 style="color: green"><c:out value="${ success }"></c:out></h4>
	<h4 style="color: red"><c:out value="${ error }"></c:out></h4>

	
	<div class="row">
		<p> Answers: </p>
		<ul>
			<c:forEach items="${question.answers}" var="answer">
				<li> ${answer.aText} </li>
			</c:forEach>
		</ul>
		<form action="/questions/${question.id}" method="POST">
		    <p>
		        <label for="newAnswer"> Answer:</label>
		        <input type="text" name="newAnswer"/>
		    </p>
		    <input type="submit" value="Answer the question"/>
		</form>
	</div>
	<br>
	<a href="/q_dashboard">Go to question dashboard</a><br>
	<a href="/new_question">Create a new question</a>
</body> 
</html>