<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Page</title>
<%@ page import = "qofd.Models.User" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import = "qofd.Models.Question" %>
<%@ page import = "qofd.Models.Option" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.List" %>
<%@ page import=  "java.text.SimpleDateFormat" %>
<%@ page import= "java.util.Calendar"%>
<%@ page import= "java.util.Date"%>

<spring:url value="/resources/style.css" var="stylecss" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="${stylecss}" rel="stylesheet" />
<spring:url value="/resources/images/watch.svg" var="followicon" />
<spring:url value="/resources/images/unwatch.svg" var="unfollowicon" />
</head>
<%

SimpleDateFormat monthformat = new SimpleDateFormat("MMM-dd-yyyy hh:mm:");


SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.0");
Calendar today = Calendar.getInstance();


		
		User user = new User();
		if(session.getAttribute("user") == null)
			response.sendRedirect("/QuestionOfTheDayWeb");
		else
			user = (User) session.getAttribute("user");
		
		
		
		String sort = request.getParameter("sort");
		String Page = request.getParameter("page");

		
		if(sort == null || sort == "date")
			sort = "date";
		if(Page == null)
			Page = "1";
		
		int pagenum = Integer.parseInt(Page);
		
		List<Question> QuestionList = (List<Question>) pageContext.getAttribute("questionList", PageContext.REQUEST_SCOPE);
		HashMap<Integer,List<Option>> topOption =(HashMap<Integer,List<Option>>) pageContext.getAttribute("optionList", PageContext.REQUEST_SCOPE);
		HashMap<Integer,Integer> userChoices = (HashMap<Integer,Integer>) pageContext.getAttribute("userChoices", PageContext.REQUEST_SCOPE);
		HashSet<Integer> userWatching = (HashSet<Integer>) pageContext.getAttribute("userWatching", PageContext.REQUEST_SCOPE);
		Integer followCount = (Integer) pageContext.getAttribute("followCount", PageContext.REQUEST_SCOPE);
		HashMap<Integer, User> creatorList = (HashMap<Integer, User> ) pageContext.getAttribute("creatorList", PageContext.REQUEST_SCOPE);

		

		int pagecount = (int) Math.ceil((double)userChoices.size()/ 5);



	
	

		
		
%>
<body>




<h1 class = middlecontainerHeading>

<%
	

if(sort.equals("date"))
{
out.print("My Recent Follows");
out.print("<div type= 'button' class='pagebutton' sort='rank' value ='1'>Sort by follows</div>");
out.print("<br>");
out.print("<div class='pageClicker'>");


if(pagecount <= 7)
{
	for(int i = 1; i <= pagecount; i++)
	{
	out.print("<input type= 'button' class='pagebutton' sort='date' value ='"+i+"'/>");
	}
}
else if(pagenum <= 3)
{
	for(int i = 1; i <= 7; i++)
	{
	out.print("<input type= 'button' class='pagebutton' sort='date' value ='"+i+"'/>");
	}
}

else if(pagecount - pagenum <= 3)
{
	for(int i = pagecount -6; i <= pagecount; i++)
	{
	out.print("<input type= 'button' class='pagebutton' sort='date' value ='"+i+"'/>");
	}
}

else
{
	out.print("<input type= 'button' class='pagebutton' sort='date' value ='"+(pagenum - 3)+"'/>");
	out.print("<input type= 'button' class='pagebutton' sort='date' value ='"+(pagenum - 2)+"'/>");
	out.print("<input type= 'button' class='pagebutton' sort='date' value ='"+(pagenum - 1)+"'/>");
	out.print("<input type= 'button' class='pagebutton' sort='date' value ='"+(pagenum   )+"'/>");
	out.print("<input type= 'button' class='pagebutton' sort='date' value ='"+(pagenum + 1)+"'/>");
	out.print("<input type= 'button' class='pagebutton' sort='date' value ='"+(pagenum + 2)+"'/>");
	out.print("<input type= 'button' class='pagebutton' sort='date' value ='"+(pagenum + 3)+"'/>");
	
}

}
else if(sort.equals("rank"))
{

	out.print("Popular Follows");
	out.print("<div type= 'button' class='pagebutton' sort='date' value ='1'>Sort by date </div>");
	out.print("<br>");
	out.print("<div class='pageClicker'>");
	if(pagecount <= 7)
	{
		for(int i = 1; i <= pagecount; i++)
		{
		out.print("<input type= 'button' class='pagebutton' sort='rank' value ='"+i+"'/>");
		}
	}
	else if(pagenum <= 3)
	{
		for(int i = 1; i <= 7; i++)
		{
		out.print("<input type= 'button' class='pagebutton' sort='rank' value ='"+i+"'/>");
		}
	}
	
	else if(pagecount - pagenum <= 3)
	{
		for(int i = pagecount -6; i <= pagecount; i++)
		{
		out.print("<input type= 'button' class='pagebutton' sort='rank' value ='"+i+"'/>");
		}
	}
	
	else
	{
		out.print("<input type= 'button' class='pagebutton' sort='rank' value ='"+(pagenum - 3)+"'/>");
		out.print("<input type= 'button' class='pagebutton' sort='rank' value ='"+(pagenum - 2)+"'/>");
		out.print("<input type= 'button' class='pagebutton' sort='rank' value ='"+(pagenum - 1)+"'/>");
		out.print("<input type= 'button' class='pagebutton' sort='rank' value ='"+(pagenum   )+"'/>");
		out.print("<input type= 'button' class='pagebutton' sort='rank' value ='"+(pagenum + 1)+"'/>");
		out.print("<input type= 'button' class='pagebutton' sort='rank' value ='"+(pagenum + 2)+"'/>");
		out.print("<input type= 'button' class='pagebutton' sort='rank' value ='"+(pagenum + 3)+"'/>");
		
	}
	
	out.print("</div>");

}


%>


</h1>
<%
today.add(Calendar.DATE, 1);
today.set(Calendar.HOUR_OF_DAY, 0);
today.set(Calendar.MINUTE,0);
today.set(Calendar.SECOND,0);
today.set(Calendar.MILLISECOND,0);


for(Question q: QuestionList)
{
	Date currentday = today.getTime();
	Date questiondate = sdf.parse(q.getDate());
	Long diffDays = (currentday.getTime() - questiondate.getTime()) / (1000 * 60 * 60 * 24);
	User creator = creatorList.get(q.getUser_id());


	int chosen = 0;
	if(userChoices.containsKey(q.getQuestion_id()))
	{		
	chosen = userChoices.get(q.getQuestion_id());
	}
	

		if(diffDays <= 7)
		{
			out.print("<div class = 'Questionformcontainer'  style= 'border-color:green;'>");

			out.print("<form class='questionform' method = 'post'>");
			out.print("<input type='hidden' name = 'page' value = '" + Page + "'>");
			out.print("<input type='hidden' name = 'sort' value = '" + sort + "'>");
			out.print("<div class = 'QuestionformHeader'>");
			out.print("<div class = 'containerleftheader' >"+ creator.getFirst_name() +" " + creator.getLast_name() +  " <br> Users Following " + q.getQuestion_score());
			
			if(chosen != 0)
			{
				out.print("<span>");

				%>
				
				<button class='followbutton' type= 'submit' name='questionbutton' value ='Submit'>
				<img class='followicon' src="${followicon}">
				</button>
				<% 
			}
			else
			{
				out.print("<span>");
				%>
				<input type='hidden' name = 'follow' value = 'follow'>
				<button class='followbutton' type= 'submit' name='questionbutton' value ='Submit'>
				<img class='followicon' src="${unfollowicon}">
				</button>
				<% 
			}
			
			out.print("</span>" );
			out.print("</div>");
			
			out.print("<div class = 'containerrightheader'> "+  monthformat.format(sdf.parse(q.getDate()))  + "</div>");

			out.print("</div>");
			
			out.print("<p><a class ='current' name='question" + q.getQuestion_id() + "'" +  "href ='Questions?&questionid=" + q.getQuestion_id()+ "'>" + q.getQuestion_text() + "</a> </p>");
			
			
			
			out.print("<div class= 'QuestionChoiceContainer'>");

			for(Option option:topOption.get(q.getQuestion_id()))
			{
				out.print("<input type='hidden' name = 'questionid' value = '" + q.getQuestion_id() + "'>");

				out.print("<div class = 'QuestionChoices'>");

				if(chosen == option.getOptions_id())
			{
					
					
				
				out.print("<input type='radio' name = 'optionid' value = '" + option.getOptions_id() + "' disabled='disabled' checked> "+ option.getOption_text());
				out.print("!");}
				else{
				out.print("<input type='radio' name = 'optionid' value = '" + option.getOptions_id() + "'>"+ option.getOption_text());
				}
				
				out.print(option.getOption_score());
				out.print("</div>");

			}
			out.print("</div>");

		out.print("</form>");
			
			
		}
		

	
	else{
		out.print("<div class = 'Questionformcontainer'  style= 'border-color:red;'>");

		
		out.print("<div class = 'QuestionformHeader'>");
		out.print("<div class = 'containerleftheader' >"+ creator.getFirst_name() +" " + creator.getLast_name() +  " <br> Users Following " + q.getQuestion_score());
		
		if(chosen != 0)
		{
			out.print("<span>");

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
		
		out.print("<div class = 'containerrightheader'> "+  monthformat.format(sdf.parse(q.getDate()))  + "</div>");

		out.print("</div>");
		
		out.print("<p><a class ='archive' name='question" + q.getQuestion_id() + "'" +  "href ='Questions?&questionid=" + q.getQuestion_id()+ "'>" + q.getQuestion_text() + "</a> </p>");
		
		
		out.print("<div class= 'QuestionChoiceContainer'>");

		for(Option option:topOption.get(q.getQuestion_id()))
		{
			out.print("<div class = 'QuestionChoices'>");


			if(chosen == option.getOptions_id())
			{				
				
			out.print("<input type='radio' name = 'optionid' value = '" + option.getOptions_id() + "' disabled='disabled' checked> "+ option.getOption_text());
			out.print("!");}
			else{
			out.print("<input type='radio' name = 'optionid' value = '" + option.getOptions_id() + "' disabled>"+ option.getOption_text());
			}
				
			out.print(option.getOption_score());
			
			
			
			out.print("</div>");

		}
		
		out.print("</div>");

			
		}
	out.print("</div>");


		
	}
	


%>
</body>


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

 
	 out.print("['Active Questions',"  + (followCount) + "],");
	 out.print("['Archived Questions',"  + (userChoices.size() - followCount) + "],");
	 out.print("['Pending Questions',"  + (userWatching.size())+ "],");
	 

	%>
]);

        // Set chart options
        var options = {'title':'You are following:',
        				height: 500,
        				legend: { position: 'bottom', alignment: 'center' },
						sliceVisibilityThreshold:0,
						colors: ['green','red','purple'],
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

        
    
        $.ajax({
        	dataType: "html",
            url: "UserPageChangeChoice", // Get the action URL to send AJAX to
            type: "POST",
            data: form.serialize(), // get all form variables
            success: function(result){
            		$(".middlecontainer").html(result);            	          	
            }
        });
        
        if(dataObj['optionid'] == null)
        {
        	console.log("HERE");
        	$.ajax({
        		type: "get",
        		cache:false,
        		url:"/QuestionOfTheDayWeb/UserInformation",
        		data:"",
        		success:function(response){
        			$(".leftcontainer").html(response);
        		}
        	})
     	 }
        
    });
    
    $(".pagebutton").on("click", function (event) {
        event.preventDefault();
        var data = '&page='+ $(this).attr("value")+ "&sort="+ $(this).attr("sort")+ "&menutype=pending";
  $.ajax({
        	dataType: "html",
            url: 'UserPageFollowing', // Get the action URL to send AJAX to
            type: "POST",
            data: data, // get all form variables
            success: function(result){
            		$(".middlecontainer").html(result);   	
            }
        });
    });
});
    
 </script>
</html>