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
HashMap<Integer,User> commentUsers = null;
User creator = null;


Question question = (Question) pageContext.getAttribute("question", PageContext.REQUEST_SCOPE);
options = (List<Option>) pageContext.getAttribute("options", PageContext.REQUEST_SCOPE);
choice = (Integer) pageContext.getAttribute("choice", PageContext.REQUEST_SCOPE);
creator = (User) pageContext.getAttribute("creator", PageContext.REQUEST_SCOPE);

List<Comments> commentList = (List<Comments>) pageContext.getAttribute("commentList", PageContext.REQUEST_SCOPE);
commentUsers = (HashMap<Integer,User>) pageContext.getAttribute("commentUsers", PageContext.REQUEST_SCOPE);


out.print("<div class = 'current' > <h1 class ='middlecontainerHeading'> Current Question </h1> </div>");
if(!options.isEmpty())
{
	out.print("<div class = 'Questionformcontainer'>");
	out.print("<form class='questionform' method = 'post'>");
	out.print("<input type='hidden' name = 'questionid' value = '" + question.getQuestion_id() + "'>");
	
	out.print("<div class = 'QuestionformHeader'>");
	out.print("<div class = 'containerleftheader' >"+ creator.getFirst_name() +" " + creator.getLast_name() +  " <br> Users Watching " + question.getQuestion_score());

	
	if(choice != 0)
	{
		out.print("<span >");
		%>
			<button class='followbutton' type= 'submit' name='questionbutton' value ='follow'>
			<img class='followicon' src="${followicon}">
			</button>
		<% 
	}
	else
	{
		out.print("<span>");
		%>
			<input type='hidden' name = 'follow' value = 'follow'>
			<button class='followbutton' type= 'submit' name='questionbutton' value ='follow'>
			<img class='followicon' src="${unfollowicon}">
			</button>
		<% 
		
		
	}
	out.print("</span>" );

	out.print("</div>");
	
	out.print("<div class = 'containerrightheader'> "+  monthformat.format(sdf.parse(question.getDate()))  + "</div>");

	out.print("</div>");
	
	
	out.print("<p>" + question.getQuestion_text() + "</p>");

	
	out.print("<div class= 'QuestionChoiceContainer'>");

	for(Option o: options)
	{
		out.print("<div class = 'QuestionChoices'>");
		if(o.getOptions_id() == choice)
		{
		out.print("<input type='radio' name = 'optionid' value = '" + o.getOptions_id() + "' disabled='disabled' checked> "+ o.getOption_text());
		}
		else{
		out.print("<input type='radio' name = 'optionid' value = '" + o.getOptions_id() + "'>"+ o.getOption_text());
		}
		out.print(o.getOption_score());
		
		out.print("</div>");

	}

	
	out.print("</div>");

	out.print("</form>");
	
}
	if(choice != 0){
%>

			<form class = "commentform" method = "post">
			<input type='hidden' name = 'questionid' value ='<%=question.getQuestion_id()%>'>
			<input type='hidden' name = 'choice' value ='<%=choice%>'>
  			<textarea class= "CommentFormText" name="getcomment" rows="10" cols="30" placeholder="Enter comment here"></textarea>
 			 <input type="submit" name='Commentsubmit' value= 'Comment'>
			</form>
<%


	
}
	else
	{
	
		%>
		  	<textarea class= "CommentFormText" name="getcomment" rows="10" cols="30" placeholder="You Must Be Following to enter a comment" disabled></textarea>
		
		
		<%
	}
	
	out.print("</div>");
	HashMap<Integer,String> optionList = new HashMap<Integer,String>();
	for(Option o: options)
	{
		optionList.put(o.getOptions_id(), o.getOption_text());
	}

	out.print("<div class = 'CommentContainer'>");
	
	for(Comments comment: commentList)
	{		User commentUser = commentUsers.get(comment.getUser_id());

		
		out.print("<div class = 'CommentElement'>");
		out.print("<div class = 'QuestionformHeader'>");
		out.print("<div class = 'containerleftheader' >"+ commentUser.getFirst_name() +" " + commentUser.getLast_name() +  " <br> ");
		out.print("Chose " + optionList.get(comment.getOption_id()));
		out.print("</div>");
		out.print("<div class = 'containerrightheader'> "+  monthformat.format(sdf.parse(comment.getComment_date()))  + "</div>");
		out.print("</div>");
		
		out.print("<p>" +  comment.getComment_text() + "</p>");
		
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


<script> 
$(document).ready(function(){
	
	 
    $(".questionform").on("submit", function (event) {
        event.preventDefault();
        var form = $(this);
        var dataArray  = form.serializeArray();
        
        dataObj = {};
        
        $(dataArray).each(function(i, field){
        	  dataObj[field.name] = field.value;
        	});

        
        if(!(dataObj['follow'] != null && dataObj['optionid'] == null))
        {
        $.ajax({
        	dataType: "html",
            url: 'ChooseCurrent', // Get the action URL to send AJAX to
            type: "POST",
            data: form.serialize(), // get all form variables
            success: function(result){
           	$(".middlecontainer").html(result);  
            	$.ajax({
            		dataType: "html",
            		url: 'QuestionInfo', // Get the action URL to send AJAX to
            		type: "POST",
            		data: form.serialize(), // get all form variables
           			success: function(result){
            		$(".leftcontainer").html(result);            	          	
            		}
            	});
          		}
      		 });
        
        }
       
    });
    
    $(".commentform").on("submit", function (event) {
        event.preventDefault();
        var form = $(this);
        $.ajax({
        	dataType: "html",
            url: 'SubmitComment', // Get the action URL to send AJAX to
            type: "POST",
            data: form.serialize(), // get all form variables
            success: function(result){
            		$(".middlecontainer").html(result);            	          	
            }
        });
    });
});


</script>


</body>
</html>