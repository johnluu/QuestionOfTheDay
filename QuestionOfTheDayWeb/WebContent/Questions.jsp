<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<%@ page import = "qofd.Dao.UserChoicesDAO" %>
<%@ page import = "qofd.Dao.UserWatchingDAO" %>
<%@ page import = "qofd.Dao.NewQuestionDAO" %>
<%@ page import = "qofd.Dao.QuestionDAO" %>
<%@ page import = "qofd.Models.Question" %>
<%@ page import = "qofd.Dao.OptionDAO" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.List" %>
<%@ page import = "qofd.Models.User" %>
<%@ page import = "qofd.Models.Option" %>




<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Questions</title>
</head>

<%! QuestionDAO qDAO = new QuestionDAO();%>
<%! OptionDAO oDAO = new OptionDAO();%>
<%! UserChoicesDAO ucDAO = new UserChoicesDAO(); %>
<%! NewQuestionDAO nqDAO = new NewQuestionDAO(); %>
<%! UserWatchingDAO uwDAO = new UserWatchingDAO(); %>


	<%
		List<Option> options = null;
		Question question = new Question();
		User user = new User();
		boolean isnew = false;
		if(session.getAttribute("user") == null)
			response.sendRedirect("HomePage.jsp");
		else
		{
			user = (User) session.getAttribute("user");
			
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.0");
		SimpleDateFormat monthformat = new SimpleDateFormat("MMM-dd-yyyy");
		
		String Questionid;
		if(request.getParameter("question") == null)
		{
			response.sendRedirect("DashBoard.jsp");
		}
		else
		{
			
			question = qDAO.getQuestion(Integer.parseInt(request.getParameter("question")));
			String questiondate = monthformat.format(sdf.parse(question.getDate()));
			String today = monthformat.format(new Date());
			
			if(questiondate.equals(today))
				 isnew = true;
		}
%>


<body>
<%@ include file = "Header.jsp" %>

<div class = "maincontainer">


<div class = "leftcontainer"> 


</div>

<div class = 'middlecontainer'>
<h1 class = middlecontainerHeading> <% if(isnew) out.print("New Question"); else out.print("Old Question"); %></h1>
<% 
int choice = 0;
choice = ucDAO.getUserQChoice(user.getUser_id(), question.getQuestion_id());
options = oDAO.getQuestionOption(question.getQuestion_id());
out.print(question.getQuestion_text());
if(!options.isEmpty())
{

	out.print("<form method = 'post'>");
	for(Option o: options)
	{
		if(o.getOptions_id() == choice)
		out.print("<input type='radio' name = 'optionvalue" + "' value = '" + o.getOptions_id() + "' disabled='disabled' checked> "+ o.getOption_text());
		else
		out.print("<input type='radio' name = 'optionvalue" + "' value = '" + o.getOptions_id() + "'> "+ o.getOption_text());

		out.print("<input type= 'submit' name='questionbutton" + question.getQuestion_id() + "' value ='Submit'>");

	}
	out.print("</form>");
	
	
	if(request.getParameter("questionbutton") != null)
	{	
		
		String optionid = request.getParameter("optionvalue");
		if (optionid != null)
		{
			if(choice == 0)
			{
				ucDAO.createUserChoice(user.getUser_id(), question.getQuestion_id(), Integer.parseInt(optionid));
			}
			else
			{
				ucDAO.changeUserChoice(user.getUser_id(), question.getQuestion_id(), choice, Integer.parseInt(optionid));
				
			}
			response.sendRedirect("question.jsp");
		}
	}
	
	
	
	
	
}
%>


</div>

<div class = "rightcontainer"> 


</div>




</div>












<%} %>
		
		
			
	

</body>
</html>