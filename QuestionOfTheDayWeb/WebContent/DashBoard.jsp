<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import = "qofd.Dao.UserChoicesDAO" %>
<%@ page import = "qofd.Dao.QuestionDAO" %>
<%@ page import = "qofd.Dao.OptionDAO" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.List" %>
<%@ page import = "qofd.Dao.UserWatchingDAO" %>
<%@ page import = "qofd.Models.Question" %>
<%@ page import = "qofd.Models.User" %>
<%@ page import = "qofd.Models.Option" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Calendar" %>






<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Dashboard</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<%! QuestionDAO qDAO = new QuestionDAO();%>
<%! OptionDAO oDAO = new OptionDAO();%>
<%! UserChoicesDAO ucDAO = new UserChoicesDAO(); %>
<%! UserWatchingDAO uwDAO = new UserWatchingDAO(); %>

<%
		String menu = request.getParameter("menu");
		String Page = request.getParameter("page");
		out.print(menu);
 %>

<% 

User user = new User();

if(session.getAttribute("user") == null)
	response.sendRedirect("HomePage.jsp");
else
	user = (User) session.getAttribute("user");

%>

</head>
<body>

<%@ include file = "Header.jsp" %>


<div class = 'maincontainer'>


<% if(menu != null && menu.equals( "archivequestion")){  %>
<div class = 'leftcontainer'>
<h1 class = 'leftcontainerHeading'> <a href ='DashBoard.jsp?&menu=questionbydate'>Today's Question</a></h1>
<jsp:include page ="questionsub.jsp"/>

</div>

<div class = 'middlecontainer'>
<h1 class = middlecontainerHeading> Archived Question</h1>
<jsp:include page ="questionarchivemain.jsp"/>
</div>

<div class = 'rightcontainer'>
<h1 class = 'rightcontainerHeading'><a href ='DashBoard.jsp?&menu=pendingquestion'>Pending questions</a></h1>
<jsp:include page ="pendingquestionsub.jsp"/>

</div>
<%}  %>


<% if(menu == null || menu.equals("questionbydate")){  %>
<div class = 'leftcontainer'>
<h1 class = 'leftcontainerHeading'> <a href ='DashBoard.jsp?&menu=archivequestion'> Archived Question </a></h1>
<jsp:include page ="questionarchivesub.jsp"/>


</div>

<div class = 'middlecontainer'>
<jsp:include page ="questionmain.jsp"/>
</div>

<div class = 'rightcontainer'>
<h1 class = 'rightcontainerHeading'><a href ='DashBoard.jsp?&menu=pendingquestion'>Pending questions</a></h1>
<jsp:include page ="pendingquestionsub.jsp"/>

</div>
<%}  %>


<% if(menu != null && menu.equals( "pendingquestion")){  %>
<div class = 'leftcontainer'>
<h1 class = 'leftcontainerHeading'><a href ='DashBoard.jsp?&menu=questionbydate'>Today's Question</a></h1>
<jsp:include page ="questionsub.jsp"/>

</div>

<div class = 'middlecontainer'>
<h1 class = middlecontainerHeading>  Pending Questions </h1>
<jsp:include page ="pendingquestionmain.jsp"/>
</div>

<div class = 'rightcontainer'>
<h1 class = 'rightcontainerHeading'> <a href ='DashBoard.jsp?&menu=archivequestion'> Archived Question </a></h1>
<jsp:include page ="questionarchivesub.jsp"/>

</div>
<%}  %>

</div>

<div id = "peewee"></div>

<div class = footer></div>
</body>

<script>
//$(document).ready(function(){

//       $(".rightcontainerinsert").load("pendingquestionsub.jsp");
//});
</script>

</html>