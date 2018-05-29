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
</head>

<body>

<%! QuestionDAO qDAO = new QuestionDAO();%>
<%! OptionDAO oDAO = new OptionDAO();%>
<%! UserChoicesDAO ucDAO = new UserChoicesDAO(); %>
<%! UserWatchingDAO uwDAO = new UserWatchingDAO(); %>

<%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.0");
		SimpleDateFormat monthformat = new SimpleDateFormat("MMM-dd-yyyy");
		SimpleDateFormat timeformat = new SimpleDateFormat("hh:mm:ss");
		Calendar cal = Calendar.getInstance();


 %>




<% 

User user = new User();

if(session.getAttribute("user") == null)
	response.sendRedirect("HomePage.jsp");
else
	user = (User) session.getAttribute("user");

%>





<%
	


		List<Question> QuestionList = null;
		HashMap<Integer,List<Option>> topOption= null;
		HashMap<Integer,Integer> userChoices = null; 
	
		

				QuestionList = qDAO.getQuestionByDate(1);
				topOption = oDAO.getOptionByDate(1);
				userChoices = ucDAO.getUserChoice(user.getUser_id());
				
		
%>
			
<%


	for(Question q: QuestionList)
	{	
		int chosen = 0;
		
		if(userChoices.containsKey(q.getQuestion_id()))
		{		
		chosen = userChoices.get(q.getQuestion_id());
		}
		
		
		
		out.print("<div class = 'Questionformcontainer'>");
		out.print("<a name='question" + q.getQuestion_id() + "'" +  "href ='Questions.jsp?&question=" + q.getQuestion_id()+ "'>" + q.getQuestion_text() + "</a>" + q.getQuestion_score()  +  "<br/>");
		out.print("<p> "+  timeformat.format(sdf.parse(q.getDate()))  + "</p> <br/>");
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
				
				response.sendRedirect("#question"+q.getQuestion_id());
				out.print("<script>reload()</script>");
			}
		}
		
	}

%>






<script> function reload(){
	
	location.reload(true);
	
}</script>



</body>
</html>