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
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<html>
<head>
<spring:url value="/resources/images/watch.svg" var="followicon" />
<spring:url value="/resources/images/unwatch.svg" var="unfollowicon" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<head>

<%
	


	
	
String sort = request.getParameter("sort");
String Page = request.getParameter("page");


if(sort == null || sort == "date")
	sort = "date";
if(Page == null)
	Page = "1";

int pendingCount = (Integer) pageContext.getAttribute("pendingCount", PageContext.REQUEST_SCOPE);
int pagecount = (int) Math.ceil((double)pendingCount/ 5);
		
%>


</head>


<body>
<%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.0");
		SimpleDateFormat monthformat = new SimpleDateFormat("hh:mm:ss");
		SimpleDateFormat timeformat = new SimpleDateFormat("hh:mm:ss");

		
		
 %>
<div class = 'pending'>
<h1 class = middlecontainerHeading>

<%

int pagenum = Integer.parseInt(Page);


out.print("Pending Questions");

if(sort.equals("date"))
{
	


	
	

		out.print("<div type= 'button' class='pagebutton' sort='rank' value ='1'>Sort by rank </div>");
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
		
		out.print("</div>");
		
		

	
}

else if(sort.equals("rank"))
{

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
</div>

<% 

User user = new User();

if(session.getAttribute("user") == null)
	response.sendRedirect("HomePage.jsp");
else
	user = (User) session.getAttribute("user");

%>





<% 

List<Question> QuestionList = null;
HashSet<Integer> userWatching = null;
HashMap<Integer,List<Option>> topOption= null;
HashMap<Integer, User> creatorList= null;


	QuestionList = (List<Question>) pageContext.getAttribute("QuestionList", PageContext.REQUEST_SCOPE);
	topOption = (HashMap<Integer,List<Option>>) pageContext.getAttribute("topOption", PageContext.REQUEST_SCOPE);
    userWatching = (HashSet<Integer>) pageContext.getAttribute("userWatching", PageContext.REQUEST_SCOPE);
    creatorList = (HashMap<Integer, User> ) pageContext.getAttribute("creatorList", PageContext.REQUEST_SCOPE);



	
	
	for(Question q: QuestionList)
	{	
		User creator = creatorList.get(q.getUser_id());
		
		boolean watching = false;
		if(userWatching.contains(q.getQuestion_id()))
			watching = true;
		

			out.print("<div class = 'Questionformcontainer' style= 'border-color:purple;'>");
			out.print("<div class = 'QuestionformHeader'>");

			out.print("<div class = 'containerleftheader' >"+ creator.getFirst_name() +" " + creator.getLast_name() +  " <br> Users Watching " + q.getWatches());

			
			if(watching)
			{
				out.print("<span type= 'button' class='watchbutton' questionid='"+ q.getQuestion_id()+ "'sort='"+ sort + "'page='"+Page+"'value ='UnWatch' >");

				%>
				
				<img class='followicon' src="${followicon}">
				
				
				<% 
				
			}
			else
			{
				out.print("<span type= 'button' class='watchbutton' questionid='"+ q.getQuestion_id()+ "'sort='"+ sort + "'page='"+Page+"' value ='Watch' >");

				%>
				<img class='followicon' src="${unfollowicon}">
				
				<% 
				
			}
			out.print("</span>" );
			
			out.print("</div>");
			
			out.print("<div class = 'containerrightheader'> "+  timeformat.format(sdf.parse(q.getDate()))  + "</div>");

			
			
			out.print("</div>");
			


			
			out.print("<p><a class='pending' href ='Questions?&questionid=" + q.getQuestion_id()+ "'>" + q.getQuestion_text() + "</a></p>");

			
			out.print("<div class= 'QuestionChoiceContainer'>");
			for(Option option:topOption.get(q.getQuestion_id()))
			{
				out.print("<div class = 'QuestionChoices'>");
				out.print("<input type='radio' name = 'rankoptionquestion" + q.getQuestion_id()+"' value = '" + option.getOptions_id() + "' disabled>"+ option.getOption_text());
				
					
				out.print(" " + option.getOption_score());
				out.print("</div>");
			}
			
			out.print(" </div>");


		
		out.print("</div>");
	}
	
%>


</body>






<script>
	
	$(document).ready(function(){
		
		 
	    $(".pagebutton").on("click", function (event) {
	        event.preventDefault();
	        var data = '&page='+ $(this).attr("value")+ "&sort="+ $(this).attr("sort")+ "&menutype=pending";
	  $.ajax({
	        	dataType: "html",
	            url: 'QuestionMain', // Get the action URL to send AJAX to
	            type: "GET",
	            data: data, // get all form variables
	            success: function(result){
	            		$(".middlecontainer").html(result);   	
	            }
	        });
	    });
		
		
		
		    $(".watchbutton").on("click", function (event) {
		        event.preventDefault();
		        var data = '&watching='+ $(this).attr("value")+ "&sort="+ $(this).attr("sort")+"&page="+ $(this).attr("page")+'&questionid='+ $(this).attr("questionid")+ '&type=main&menutype=pending';
		  $.ajax({
		        	dataType: "html",
		            url: 'QuestionWatch', // Get the action URL to send AJAX to
		            type: "POST",
		            data: data, // get all form variables
		            success: function(result){
		            		$(".middlecontainer").html(result);   	
		            }
		        });
		    });
			
			
});

</script>



</body>
</html>