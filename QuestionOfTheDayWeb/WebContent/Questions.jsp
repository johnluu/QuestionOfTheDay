<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<%@ page import = "qofd.Dao.UserDAO" %>
<%@ page import = "qofd.Dao.UserChoicesDAO" %>
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
<%@ page import = "qofd.Models.Comments" %>
<%@ page import = "qofd.Dao.UserWatchingDAO" %>
<%@ page import="java.util.HashSet" %>






<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Questions</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>

<%! QuestionDAO qDAO = new QuestionDAO();%>
<%! OptionDAO oDAO = new OptionDAO();%>
<%! UserChoicesDAO ucDAO = new UserChoicesDAO(); %>

<%! CommentDAO cDAO = new CommentDAO(); %>
<%! UserDAO uDAO = new UserDAO(); %>
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
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -1);
			
			question = qDAO.getQuestionById(Integer.parseInt(request.getParameter("question")));
			String questiondate = monthformat.format(sdf.parse(question.getDate()));
			String yesterday = monthformat.format(cal.getTime());
			
			
			out.print(question.getDate());
			if(questiondate.equals(yesterday))
				 isnew = true;
		}
%>


<body>
<%@ include file = "Header.jsp" %>


<div class = 'maincontainer'>

<div class = 'leftcontainer'></div>




<div class = 'middlecontainer'>
<h1 class = middlecontainerHeading> <% if(isnew) out.print("New Question"); else out.print("Old Question"); %></h1>
<% 
int choice = 0;
choice = ucDAO.getUserQChoice(user.getUser_id(), question.getQuestion_id());
options = oDAO.getOptionsByQuestionId(question.getQuestion_id());
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

		out.print(o.getOption_score());
		out.print("<br>");

	}
	out.print("<input type= 'submit' name='questionbutton'" + "value ='Submit'>");

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
			response.sendRedirect("Questions.jsp?&question=" + question.getQuestion_id());
		}
	}
	
}
	if(choice != 0){
%>

			<form method = "post">
  			<textarea name="getcomment" rows="10" cols="30">Enter Comment Here.</textarea>
  			<br>
 			 <input type="submit" name='Commentsubmit' value= 'Comment'>
			</form>
<%
	if(request.getParameter("Commentsubmit")!= null)
	{
		String getComment = request.getParameter("getcomment");
		Comments comment = new Comments(user.getUser_id(),question.getQuestion_id(),choice, getComment);
		
		
		cDAO.createComment(comment);
		
	}
}
	


	List<Comments> commentList = cDAO.getQuestionComments(question.getQuestion_id());

	out.print("<h1>" +  question.getQuestion_id() + "</h1>");
	for(Comments comment: commentList)
	{
		User commentUser = uDAO.getUser(comment.getUser_id());
		out.print(commentUser.getFirst_name() + " " + commentUser.getLast_name() + " says <br>");
		out.print(comment.getComment_text() + "<br>");
	}
	
%>


</div>

<div class = "rightcontainer"> 
<h1 class = 'rightcontainerHeading'> Pending Question</h1>
<%@ include file = "pendingquestion.jsp" %>

</div>




</div>













<%} %>
		
			
	

</body>
</html>