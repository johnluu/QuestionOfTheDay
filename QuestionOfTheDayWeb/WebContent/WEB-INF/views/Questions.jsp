<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<%@ page import = "qofd.Dao.UserDAO" %>
<%@ page import = "qofd.Dao.QuestionDAO" %>
<%@ page import = "qofd.Models.Question" %>
<%@ page import = "qofd.Dao.OptionDAO" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.Calendar" %>
<%@ page import = "qofd.Models.User" %>

<html>
<head>
<spring:url value="/resources/style.css" var="stylecss" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Questions</title>
<link href="${stylecss}" rel="stylesheet" />
</head>

<%! QuestionDAO qDAO = new QuestionDAO();%>
<%! OptionDAO oDAO = new OptionDAO();%>
<%! UserDAO uDAO = new UserDAO(); %>




<%
		User user = new User();
		boolean isnew = false;
		if(session.getAttribute("user") == null)
			response.sendRedirect("/QuestionOfTheDayWeb");
		else
			user = (User) session.getAttribute("user");
		
		int questionid = 0;
			if(request.getParameter("questionid") != null)
				questionid = Integer.parseInt(request.getParameter("questionid"));		
%>

<body>
<div class ="container">

<%@ include file = "Header.jsp" %>


<div class = 'maincontainer'>

<div class = 'leftcontainer'></div>

<div class = 'middlecontainer'> </div>

<div class = "rightcontainer"> 
      <div class = 'inner' id="chart_div"></div>
</div>
</div>


<div class = footer> @Copyright blahblahblah</div>

</div>


<script>
$(document).ready(function(){
	$.ajax({
		type: "GET",
		cache:false,
		url:"/QuestionOfTheDayWeb/Question",
		data:"&questionid=" + <%=questionid%>,
		success:function(response){
			$(".middlecontainer").html(response);
		}
	})
	
    $.ajax({
    	dataType: "html",
        url: 'QuestionInfo', // Get the action URL to send AJAX to
        type: "POST",
        data: "&questionid=" + <%=questionid%>,
        success: function(result){
        		$(".leftcontainer").html(result);            	          	
        }
    });
});


</script>
	

</body>
</html>