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

<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<%! QuestionDAO qDAO = new QuestionDAO();%>
<%! OptionDAO oDAO = new OptionDAO();%>
<%! UserChoicesDAO ucDAO = new UserChoicesDAO(); %>
<%! UserWatchingDAO uwDAO = new UserWatchingDAO(); %>

<%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.0");
		SimpleDateFormat monthformat = new SimpleDateFormat("hh:mm:ss");

 %>



<% 

User user = new User();

if(session.getAttribute("user") != null)
	user = (User) session.getAttribute("user");

%>





<%

String Page = request.getParameter("page");
if(Page == null)
	Page = "1";

	int dateOffset = Integer.parseInt(Page);
	
	List<Question> rankQuestionList = qDAO.getQuestionArchiveByDate(dateOffset);
	HashMap<Integer,List<Option>> ranktopOption= oDAO.getOptionArchiveByDate(dateOffset);
	HashMap<Integer,Integer> rankuserChoices = ucDAO.getUserChoice(user.getUser_id());
	
	

	
	 
	for(Question q: rankQuestionList)
	{
		out.print("<div class = 'Questionformcontainer'>");
		out.print("<a name='archivequestion" + q.getQuestion_id() + "'" +  "href ='Questions.jsp?&question=" + q.getQuestion_id()+ "'>" + q.getQuestion_text() + "</a>" + q.getQuestion_score()  +  "<br/>");
		out.print("<p> "+ q.getDate()  + "</p> <br/>");
		
		
		int chosen = 0;
		
		if(rankuserChoices.containsKey(q.getQuestion_id()))
		{		
		chosen = rankuserChoices.get(q.getQuestion_id());
		}
		
		
		for(Option option:ranktopOption.get(q.getQuestion_id()))
		{
			
			if(chosen == option.getOptions_id())
			{
				
			out.print("<input type='radio' name = 'rankoptionquestion" + q.getQuestion_id()+"' value = '" + option.getOptions_id() + "' disabled='disabled' checked> "+ option.getOption_text());
			out.print("!");}
			else{
			out.print("<input type='radio' name = 'rankoptionquestion" + q.getQuestion_id()+"' value = '" + option.getOptions_id() + "' disabled>"+ option.getOption_text());
			}
				
			out.print(" " + option.getOption_score() + "</br>");
		}
		out.print("</div>");
		

		
	}

	out.print("<a href ='DashBoard.jsp?&menu=archivequestion&page=1'>" + "1" + "</a>");
	out.print("<a href ='DashBoard.jsp?&menu=archivequestion&page=2'>" + "2" + "</a>");
	out.print("<a href ='DashBoard.jsp?&menu=archivequestion&page=3'>" + "3" + "</a>");
	out.print("<a href ='DashBoard.jsp?&menu=archivequestion&page=4'>" + "4" + "</a>");
	out.print("<a href ='DashBoard.jsp?&menu=archivequestion&page=5'>" + "5" + "</a>");
	out.print("<a href ='DashBoard.jsp?&menu=archivequestion&page=6'>" + "6" + "</a>");
	out.print("<a href ='DashBoard.jsp?&menu=archivequestion&page=7'>" + "7" + "</a>");
	
%>






<script> function reload(){
	
	location.reload(true);
	
}</script>



</body>
</html>