<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import = "qofd.Dao.UserDAO" %>
<%@ page import = "qofd.Dao.QuestionDAO" %>
<%@ page import = "qofd.Models.Question" %>
<%@ page import = "qofd.Dao.OptionDAO" %>
<%@ page import = "qofd.Dao.CommentDAO" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.Calendar" %>
<%@ page import = "java.util.List" %>
<%@ page import = "qofd.Models.User" %>
<%@ page import = "qofd.Models.Option" %>
<%@ page import="java.util.HashSet" %>
<%@ page import = "qofd.Dao.UserWatchingDAO" %>




<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Pending Question </title>
</head>

<%! QuestionDAO qDAO = new QuestionDAO();%>
<%! OptionDAO oDAO = new OptionDAO();%>
<%! UserDAO uDAO = new UserDAO(); %>


<body>
<h1>Pending question</h1>
<% 
User user = new User();

if(session.getAttribute("user") == null)
	response.sendRedirect("HomePage.jsp");
else
	user = (User) session.getAttribute("user");


List<Option> options = null;
Question question = new Question();
question = qDAO.getQuestionById(Integer.parseInt(request.getParameter("question")));
options = oDAO.getOptionsByQuestionId(question.getQuestion_id());


out.print(question.getQuestion_text());
if(!options.isEmpty())
{

	out.print("<form method = 'post'>");
	for(Option o: options)
	
		
		out.print("<input type='radio' name = 'optionvalue" + "' value = '" + o.getOptions_id() + "' disabled> "+ o.getOption_text());
		out.print("<br>");

	

	
	

	
}

	



	
%>

</body>
</html>