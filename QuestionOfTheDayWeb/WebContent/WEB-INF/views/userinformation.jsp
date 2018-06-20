<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Page</title>
<%@ page import = "qofd.Models.User" %>




</head>
<body>
<div class = 'inner'>


<%
		
		User user = new User();
		boolean isnew = false;
		if(session.getAttribute("user") == null)
			response.sendRedirect("/QuestionOfTheDayWeb");
		else
			user = (User) session.getAttribute("user");
		
		int following[] = (int[]) pageContext.getAttribute("following", PageContext.REQUEST_SCOPE);

		
%>
<h1 class= "subcontainerHeading">User Information</h1>


<div class="Informationdiv">
<p> Name: ${userinformation.first_name} ${userinformation.last_name} </p>
<p> Join Date: ${userinformation.join_date} </p>
<p> Total Watchers: ${userinformation.watches} </p>
<p> Questions Followed: ${userinformation.choices} </p>
<p> Questions Created: ${userinformation.questions_created} </p>
<p> Comments Created: ${userinformation.comments} </p>
<%
out.print("<p> Active Created Questions " + following[0] + "</p>");
out.print("<p> Currently Followng " + following[1] + "</p>");
out.print("<p> Currently Watching " + following[2] + "</p>");

%>
</div>






</div>
</body>
</html>