<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page import = "qofd.Models.Question" %>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div class = 'inner'>
<% 
Question question = (Question) pageContext.getAttribute("question", PageContext.REQUEST_SCOPE);
String status= (String) pageContext.getAttribute("status", PageContext.REQUEST_SCOPE);

%>

<h1 class = middlecontainerHeading>
Question Information
</h1>

<div class = "Informationdiv">
<p>Status ${status}</p>
<p>Question id: ${question.question_id}</p>
<p>Created by ${createdBy.first_name} ${createdBy.last_name}</p>
<%if(status.equals("Pending")) {%>
<p>Users Following: N/A</p>
<%}else {%>
<p>Users Following: ${question.question_score}</p>
<%}%>
<p>Watched ${question.watches}</p>
<p>Created ${question.date}</p>
<p>Age ${diffDays}</p>
<%if(status.equals("Pending")) {%>
<p>Life span: N/A</p>
<%}else {%>
<p>Life span: ${15 -diffDays}</p>
<%}%>
</div>
</div>
</body>
</html>