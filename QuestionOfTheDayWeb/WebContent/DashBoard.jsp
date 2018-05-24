<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import = "qofd.Dao.UserChoicesDAO" %>
<%@ page import = "qofd.Dao.QuestionDAO" %>
<%@ page import = "qofd.Dao.OptionDAO" %>
<%@ page import = "qofd.Dao.UserWatchingDAO" %>
<%@ page import = "qofd.Dao.NewQuestionDAO" %>
<%@ page import = "qofd.Models.Question" %>
<%@ page import = "qofd.Models.New_Question" %>
<%@ page import = "qofd.Models.User" %>
<%@ page import = "qofd.Models.Option" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.HashSet" %>





<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Dashboard</title>

<%! QuestionDAO qDAO = new QuestionDAO();%>
<%! OptionDAO oDAO = new OptionDAO();%>
<%! UserChoicesDAO ucDAO = new UserChoicesDAO(); %>
<%! NewQuestionDAO nqDAO = new NewQuestionDAO(); %>
<%! UserWatchingDAO uwDAO = new UserWatchingDAO(); %>
	



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

<div class = 'leftcontainer'></div>


<div class = 'middlecontainer'>
<h1 class = middlecontainerHeading> Today's Questions</h1>

<%
	
	List<Question> QuestionList = qDAO.getTodaysQuestion();
	HashMap<Integer,List<Option>> topOption= oDAO.getTopOption();
	HashMap<Integer,Integer> userChoices = ucDAO.getUserChoice(user.getUser_id());
	
	 
	for(Question q: QuestionList)
	{	
		int chosen = 0;
		
		if(userChoices.containsKey(q.getQuestion_id()))
		{		
		chosen = userChoices.get(q.getQuestion_id());
		}
		
		
		out.print("<div class = 'Questionformcontainer'>");
		out.print("<a href ='Questions.jsp?&question=" + q.getQuestion_id()+ "'>" + q.getQuestion_text() + "</a> <br/>");
		out.print("<p> "+ q.getDate()  + "</p> <br/>");
		out.print("<form method = 'post'>");
		
		for(Option option:topOption.get(q.getQuestion_id()))
		{

			if(chosen == option.getOptions_id())
			{
				
			out.print("<input type='radio' name = 'optionquestion" + q.getQuestion_id()+"' value = '" + option.getOptions_id() + "' disabled='disabled' checked> "+ option.getOption_text());
			out.print("!");}
			else{
			out.print("<input type='radio' name = 'optionquestion" + q.getQuestion_id()+"' value = '" + option.getOptions_id() + "'> "+ option.getOption_text());
			}
				
			out.print(" " + option.getOption_score() + "</br>");
		}
		out.print("<input type= 'submit' name='questionbutton" + q.getQuestion_id() + "' value ='Submit'>");
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
				response.sendRedirect("DashBoard.jsp");
			}
		}
		
	}
%></div>
<div class = 'rightcontainer'>
<h1 class = 'rightcontainerHeading'> New Questions</h1>
<% 
	List<New_Question> topNewQuestion = nqDAO.getTopNewQuestion();
	HashSet<Integer> userWatching = uwDAO.isWatching(user.getUser_id());


	
	for(New_Question q: topNewQuestion)
	{	
		boolean watching = false;
		if(userWatching.contains(q.getQuestion_id()))
			watching = true;
		
		
		
		out.print("<div class = 'NewQuestionformcontainer'>");
		out.print("<form method = 'post'>");	
		
		out.print( "<p>" + q.getQuestion_text() + "<br>");
		out.print(  q.getWatches() + " Users Watching </p> <br>");
		if(watching)
			out.print("<input type= 'submit' name='watcher" + q.getQuestion_id() + "' value ='UnWatch' >");
		else
			out.print("<input type= 'submit' name='watcher" + q.getQuestion_id() + "' value ='Watch' >");
		

		if(request.getParameter("watcher" + q.getQuestion_id()) != null)
		{
				
		if(watching)
			uwDAO.unwatch(user.getUser_id(), q.getQuestion_id());
		else
			uwDAO.watch(user.getUser_id(), q.getQuestion_id());

			response.sendRedirect("DashBoard.jsp");
		}
		
		out.print("</form>");		out.print("</div>");
	}
	
%>


</div>

</div>
<div class = footer></div>
</body>
</html>