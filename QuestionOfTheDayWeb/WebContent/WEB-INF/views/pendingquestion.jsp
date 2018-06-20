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
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>




<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<spring:url value="/resources/images/watch.svg" var="followicon" />
<spring:url value="/resources/images/unwatch.svg" var="unfollowicon" />
</head>


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
HashSet<Integer> userWatching = null;
User creator = null;


Question question = (Question) pageContext.getAttribute("question", PageContext.REQUEST_SCOPE);
options = (List<Option>) pageContext.getAttribute("options", PageContext.REQUEST_SCOPE);
userWatching = (HashSet<Integer>) pageContext.getAttribute("userWatching", PageContext.REQUEST_SCOPE);
int watchCount = (Integer) pageContext.getAttribute("watchCount", PageContext.REQUEST_SCOPE);
creator = (User) pageContext.getAttribute("creator", PageContext.REQUEST_SCOPE);




out.print("<div class= 'pending'> <h1 class ='middlecontainerHeading'> Pending Question </h1> </div>");



	out.print("<div class = 'Questionformcontainer'>");
	out.print("<div class = 'QuestionformHeader'>");
	out.print("<div class = 'containerleftheader' >"+ creator.getFirst_name() +" " + creator.getLast_name() +  " <br> Users Watching " + question.getQuestion_score());

	
	
	if(userWatching.contains(question.getQuestion_id()))
	{
		out.print("<span type= 'button' class='watchpending' questionid='"+ question.getQuestion_id()+ "'value ='UnWatch' >");
		%>
		<img class='followicon' src="${followicon}">
		<% 
	}
	else
	{
		out.print("<span type= 'button' class='watchpending' questionid='"+ question.getQuestion_id()+ "'value ='Watch' >");
		%>
		<img class='followicon' src="${unfollowicon}">
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

		
		out.print("<input type='radio' name = 'optionid' value = '" + o.getOptions_id() + "' disabled> "+ o.getOption_text());
		
		out.print("</div>");

	}
	
	out.print("</div>");

	out.print("<textarea class= 'CommentFormText' name='getcomment' rows='10' cols='30' placeholder='Question Is Pending' disabled></textarea>");



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
  			['Watches', 'QuestionWatches'],
 <%	

 //out.print("['"+ o.getOption_text() +  "', " + o.getOption_score() + "],");

 
	 out.print("['Other Questions',"  + (watchCount - question.getWatches())+ "],");
	 out.print("['This Question',"  + question.getWatches()+ "],");

	%>
]);

        // Set chart options
  var options = {'title':'Current Watches',
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
	
	 
    $(".watchpending").on("click", function (event) {
        event.preventDefault();
        var data = '&watching='+ $(this).attr("value")+'&questionid='+ $(this).attr("questionid");
 		 $.ajax({
        	dataType: "html",
            url: 'WatchPending', // Get the action URL to send AJAX to
            type: "POST",
            data: data, // get all form variables
            success: function(result){
            		$(".middlecontainer").html(result);  
            		
                    $.ajax({
                    	dataType: "html",
                        url: 'QuestionInfo', // Get the action URL to send AJAX to
                        type: "POST",
                        data: data, // get all form variables
                        success: function(result){
                        		$(".leftcontainer").html(result);            	          	
                        }
                    });	
            }
        });

    });
});


</script>

</body>
</html>