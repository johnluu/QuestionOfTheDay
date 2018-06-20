<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Page</title>
<%@ page import = "qofd.Models.User" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/resources/style.css" var="stylecss" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link href="${stylecss}" rel="stylesheet" />



</head>

<%
		
		User user = new User();
		boolean isnew = false;
		if(session.getAttribute("user") == null)
			response.sendRedirect("/QuestionOfTheDayWeb");
		else
			user = (User) session.getAttribute("user");
		
		int following[] = (int[]) pageContext.getAttribute("following", PageContext.REQUEST_SCOPE);

		
%>

<body>
<%@ include file = "Header.jsp" %>

<div class = 'maincontainer'>

<div class = 'leftcontainer'>



<%

%>
</div>
<div class = 'middlecontainer'> </div>

<div class = 'rightcontainer'> 
      <div class = 'inner' id="chart_div"></div>
      
</div>
</div>



</body>

<script>

$(document).ready(function(){
	

	
	$.ajax({
		type: "POST",
		cache:false,
		url:"/QuestionOfTheDayWeb/UserPageFollowing",
		data:"",
		success:function(response){
			$(".middlecontainer").html(response);
		}
	})
	
	
	$.ajax({
		type: "get",
		cache:false,
		url:"/QuestionOfTheDayWeb/UserInformation",
		data:"",
		success:function(response){
			$(".leftcontainer").html(response);
		}
	})
	
	
});

</script>




	
</html>