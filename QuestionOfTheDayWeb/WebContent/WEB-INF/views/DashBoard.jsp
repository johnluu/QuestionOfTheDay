<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import = "qofd.Models.Question" %>
<%@ page import = "qofd.Models.User" %>
<%@ page import = "qofd.Models.Option" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Calendar" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<spring:url value="/resources/style.css" var="stylecss" />



<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link href="${stylecss}" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Dashboard</title>


<%
		String menu = request.getParameter("menu");
		String Page = request.getParameter("page");

User user = new User();

if(session.getAttribute("user") == null)
	response.sendRedirect("/QuestionOfTheDayWeb");
else
	user = (User) session.getAttribute("user");

%>

</head>
<body>

<div class ="container">

<%@ include file = "Header.jsp" %>


<div class = 'maincontainer'>



<div class = 'leftcontainer'>


</div>

<div class = 'middlecontainer'>
</div>

<div class = 'rightcontainer'></div>









</div>

<div class = footer> @Copyright blahblahblah</div>

</div>




</body>


<script>

$(document).ready(function(){
	
	$.ajax({
		type: "GET",
		cache:false,
		url:"/QuestionOfTheDayWeb/QuestionMain",
		data:"",
		success:function(response){
			$(".middlecontainer").html(response);
		}
	})
	
		$.ajax({
		type: "GET",
		cache:false,
		url:"/QuestionOfTheDayWeb/QuestionSub",
		data:'&subtype=archive',
		success:function(response){
			$(".leftcontainer").html(response);
		}
	})
	
	$.ajax({
	type: "GET",
	cache:false,
	url:"/QuestionOfTheDayWeb/QuestionSub",
	data:'&subtype=pending',
	success:function(response){
		$(".rightcontainer").html(response);
	}
})
     

   
});


</script>

</html>