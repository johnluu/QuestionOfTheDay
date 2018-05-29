<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Questions</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>

<%! QuestionDAO qDAO = new QuestionDAO();%>
<%! OptionDAO oDAO = new OptionDAO();%>
<%! UserDAO uDAO = new UserDAO(); %>




	<%
	

		Question question = new Question();
		User user = new User();
		boolean isnew = false;
		if(session.getAttribute("user") == null)
			response.sendRedirect("HomePage.jsp");
		else
		{
			user = (User) session.getAttribute("user");
			question = qDAO.getQuestionById(Integer.parseInt(request.getParameter("question")));

			
			
			
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.0");
		SimpleDateFormat monthformat = new SimpleDateFormat("MMM-dd-yyyy");

		Calendar caldayago = Calendar.getInstance();
		Calendar calweekago = Calendar.getInstance();
		
		caldayago.add(Calendar.DATE, -1);
		calweekago.add(Calendar.DATE, -8);
		
		Date dayago = caldayago.getTime();
		Date weekago = calweekago.getTime();
		Date questiondate = sdf.parse(question.getDate());
		
		String questiontype = "";
		
		
		if(questiondate.compareTo(dayago)>0)
		{
			questiontype = "pending";
		}
		
		else if(questiondate.compareTo(weekago)<0)
		{
			questiontype = "archive";
		}
		
		else if(questiondate.compareTo(weekago)>=0 && questiondate.compareTo(dayago) <= 0)
		{
			questiontype = "current";
			
		}
		question = qDAO.getQuestionById(Integer.parseInt(request.getParameter("question")));
		
	
		
	
%>


<body>
<%@ include file = "Header.jsp" %>


<div class = 'maincontainer'>

<div class = 'leftcontainer'></div>




<div class = 'middlecontainer'>
<h1 class = middlecontainerHeading>  </h1>
<% if(questiontype.equals("current"))
{
%>
<jsp:include page ="currentquestion.jsp"/>
<% 
}
else if(questiontype.equals("pending"))
{
%>
<jsp:include page ="pendingquestion.jsp"/>
<% 
}
else if(questiontype.equals("archive"))
{
%>
<jsp:include page ="archivedquestion.jsp"/>
<% 
}

%>


</div>

<div class = "rightcontainer"> 
<h1 class = 'rightcontainerHeading'>  </h1>

</div>




</div>













<%} %>
		
			
	

</body>
</html>