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

if(session.getAttribute("user") == null)
	response.sendRedirect("HomePage.jsp");
else
	user = (User) session.getAttribute("user");

%>





<% 
	List<Question> PendingQuestionList = qDAO.getQuestionByDate(0);
	HashSet<Integer> userWatching = uwDAO.isWatching(user.getUser_id());


	
	for(Question q: PendingQuestionList)
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
		
		out.print("<br>" + q.getQuestion_id()); out.print(user.getUser_id() + "<br>");

		if(request.getParameter("watcher" + q.getQuestion_id()) != null)
		{
				
		if(watching)
			uwDAO.unwatch(user.getUser_id(), q.getQuestion_id());
		else
			uwDAO.watch(user.getUser_id(), q.getQuestion_id());

			response.sendRedirect("DashBoard.jsp");
		}
		
		out.print("</form>");
		out.print("</div>");
	}
	
%>






<script> function reload(){
	
	location.reload(true);
	
}</script>



</body>
</html>