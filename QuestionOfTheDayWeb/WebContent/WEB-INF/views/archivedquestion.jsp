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
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>





<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<spring:url value="/resources/images/watch.svg" var="followicon" />
<spring:url value="/resources/images/unwatch.svg" var="unfollowicon" />
</head>


<%! CommentDAO cDAO = new CommentDAO(); %>
<%! UserDAO uDAO = new UserDAO(); %>


<body>
  
<% 
User user = new User();

if(session.getAttribute("user") == null)
	response.sendRedirect("HomePage.jsp");
else
	user = (User) session.getAttribute("user");


SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.0");
SimpleDateFormat monthformat = new SimpleDateFormat("MMM-dd-yyyy hh:mm");


List<Option> options = null;
int choice = 0;
User creator = null;
HashMap<Integer,User> commentUsers = null;



Question question = (Question) pageContext.getAttribute("question", PageContext.REQUEST_SCOPE);
options = (List<Option>) pageContext.getAttribute("options", PageContext.REQUEST_SCOPE);
choice = (Integer) pageContext.getAttribute("choice", PageContext.REQUEST_SCOPE);
List<Comments> commentList = (List<Comments>) pageContext.getAttribute("commentList", PageContext.REQUEST_SCOPE);
creator = (User) pageContext.getAttribute("creator", PageContext.REQUEST_SCOPE);
commentUsers = (HashMap<Integer,User>) pageContext.getAttribute("commentUsers", PageContext.REQUEST_SCOPE);

out.print("<div class = 'archive'> <h1 class ='middlecontainerHeading'> Archived Question </h1> </div>");



if(!options.isEmpty())
{
	out.print("<div class = 'Questionformcontainer'>");
	
	out.print("<div class = 'QuestionformHeader'>");
	out.print("<div class = 'containerleftheader' >"+ creator.getFirst_name() +" " + creator.getLast_name() +  " <br> Users Watching " + question.getQuestion_score());

	if(choice != 0)
	{
		out.print("<span >");
		%>
			<img class='followicon' src="${followicon}">
		<% 
	}
	else
	{
		out.print("<span>");
		%>
			<img class='followicon' src="${unfollowicon}">
		<% 
		
		
	}
	
	out.print("</span>" );

	out.print("</div>");
	
	out.print("<div class = 'containerrightheader'> "+  monthformat.format(sdf.parse(question.getDate()))  + "</div>");

	
	out.print("<p>" + question.getQuestion_text() + "</p>");
	out.print("</div>");
	
	
	out.print("<div class= 'QuestionChoiceContainer'>");

	for(Option o: options)
	{
		out.print("<div class = 'QuestionChoices'>");

		if(o.getOptions_id() == choice)
		{
		out.print("<input type='radio' name = 'optionid' value = '" + o.getOptions_id() + "' disabled='disabled' checked> "+ o.getOption_text());
		}
		else{
		out.print("<input type='radio' name = 'optionid' value = '" + o.getOptions_id() + "'disabled>"+ o.getOption_text());
		}
		out.print(o.getOption_score());
		out.print("<br>");

		out.print("</div>");

	}
	out.print("</div>");

  	out.print("<textarea class= 'CommentFormText' name='getcomment' rows='10' cols='30' placeholder='Question Is Archived' disabled></textarea>");

	out.print("</div>");
}


HashMap<Integer,String> optionList = new HashMap<Integer,String>();
for(Option o: options)
{
	optionList.put(o.getOptions_id(), o.getOption_text());
}

out.print("<div class = 'CommentContainer'>");

for(Comments comment: commentList)
{
	
	out.print("<div class = 'CommentElement'>");

	User commentUser = commentUsers.get(comment.getUser_id());
	out.print(commentUser.getFirst_name() + " " + commentUser.getLast_name() + " says <br>");
	
	out.print(comment.getComment_text() + "<br>");
	out.print("Chose " + optionList.get(comment.getOption_id()) + "</br>");
	
	out.print("</div>");

}


out.print("</div>");
	
%>



  <script>

      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
 var data = google.visualization.arrayToDataTable([
  ['Option', 'UserChosen'],
 <%	for(Option o: options)
 {
	 out.print("['"+ o.getOption_text() +  "', " + o.getOption_score() + "],");
 }
	%>
]);
 console.log(data);

        // Set chart options
        var options = {'title':'Current Follows',
           				height: 500,
						legend: { position: 'bottom', alignment: 'center' },
          				sliceVisibilityThreshold:0,
                   		backgroundColor: '#efe6e6',

          				 
                       };

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>






</body>
</html>