<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import = "qofd.Dao.QuestionDAO" %>
<%@ page import = "qofd.Dao.OptionDAO" %>
<%@ page import = "qofd.Models.Question" %>
<%@ page import = "qofd.Models.User" %>
<%@ page import = "qofd.Models.Option" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.HashSet" %>
<%@ page import = "qofd.Dao.UserChoicesDAO" %>


<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Dashboard</title>

<%! QuestionDAO qDAO = new QuestionDAO();%>
<%! OptionDAO oDAO = new OptionDAO();%>
<%! UserChoicesDAO ucDAO = new UserChoicesDAO(); %>
	



<% 
	List<Question> QuestionList = qDAO.getTodaysQuestion();
	HashMap<Integer,List<Option>> topOption= oDAO.getTopOption();
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

<div class = 'leftcontainer'></div>


<div class = 'middlecontainer'>
<h1 class = middlecontainerHeading> Today's Questions</h1>
<%
	
	HashMap<Integer,Integer> userChoices = ucDAO.getUserChoice(user.getUser_id());
	
	
	for(Question q: QuestionList)
	{	
		int chosen = 0;
		
		if(userChoices.containsKey(q.getQuestion_id()))
		{		
		chosen = userChoices.get(q.getQuestion_id());
		}
		

		out.print("<div class = 'Questionformcontainer'>");
		out.print("<p> "+ q.getQuestion_text() + "</p> <br/>");
		out.print("<form method = 'post'>");
		
		for(Option option:topOption.get(q.getQuestion_id()))
		{

			if(chosen == option.getOptions_id())
			{out.print("<input type='radio' name = 'optionquestion" + q.getQuestion_id()+"' value = '" + option.getOptions_id() + "' disabled='disabled' checked> "+ option.getOption_text());
			out.print("!!!!!!!!");}
			else{
			out.print("<input type='radio' name = 'optionquestion" + q.getQuestion_id()+"' value = '" + option.getOptions_id() + "'> "+ option.getOption_text());
			}
				
			out.print("</br>");
		}
		out.print("<input type= 'submit' name='questionbutton" + q.getQuestion_id() + "' value ='Submit" + q.getQuestion_id() + "'>");
		out.print("</form>");
		out.print("</div>");
		
		if(request.getParameter("questionbutton" + q.getQuestion_id()) != null)
		{
			
			String optionid = request.getParameter("optionquestion" +  q.getQuestion_id());
			if (optionid != null)
			{
				if(chosen == 0)
				{
					ucDAO.createUserChoice(user.getUser_id(), q.getQuestion_id(), Integer.parseInt(optionid));
				}
				else
				{
					ucDAO.changeUserChoice(user.getUser_id(), q.getQuestion_id(), chosen, Integer.parseInt(optionid));
					
				}
			}
		}
		
	}
%></div>
<div class = 'rightcontainer'></div>
</div>
<div class = footer></div>
</body>
</html>