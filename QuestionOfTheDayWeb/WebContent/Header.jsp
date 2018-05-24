<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<div class= "header">

<% 

if(request.getParameter("logout") != null) 
	{
	session.invalidate();
	response.sendRedirect("HomePage.jsp");
	}
%>
	<h1> Welcome <%= user.getFirst_name() %></h1>
<form method ="post">
<input type= "submit" name="logout" value="logout" /> <br>
</form>
</div>