
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




</head>

<body>
<div class = inner style= "border-color:purple;">


<%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.0");
		SimpleDateFormat monthformat = new SimpleDateFormat("hh:mm:ss");

 %>
<div class='pendingbutton'>
<div class = 'pending'> 
<h1 class = subcontainerHeading>
Pending Questions
</h1>
 </div>
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

	QuestionList = (List<Question>) pageContext.getAttribute("QuestionList", PageContext.REQUEST_SCOPE);
    userWatching = (HashSet<Integer>) pageContext.getAttribute("userWatching", PageContext.REQUEST_SCOPE);


		
	
	for(Question q: QuestionList)
	{	
		boolean watching = false;
		if(userWatching.contains(q.getQuestion_id()))
			watching = true;
		
		

		out.print("<div class = 'SubQuestionformcontainer'>");
		



		out.print("Users Watching " + q.getWatches());

		if(watching)
		{
			out.print("<span type= 'button' class='watchbutton' questionid='"+  q.getQuestion_id()+ "' value ='UnWatch' >");

			%>
			
			<image class='followicon' src="${followicon}"> </image> 
			
			<% 
			
			out.print("</span> </br>" );
		}
		
		
		else
		{
			out.print("<span type= 'button' class='watchbutton' questionid='"+  q.getQuestion_id()+ "' value ='Watch' >");

			%>
			<image class='followicon' src="${unfollowicon}"> </image> 
			
			<% 
			
			out.print("</span> </br>" );
		}
		

		
		out.print("<a class = 'pending' name='question" + q.getQuestion_id() + "'" +  "href ='Questions?&questionid=" + q.getQuestion_id()+ "'>" + q.getQuestion_text() + "</a>");


	
		


		
		out.print("</div>");
	}
	
%>

</div>
</body>



<script> 
$(document).ready(function(){
	
	 
	    $(".watchbutton").on("click", function (event) {
	        event.preventDefault();
	        var data = '&watching='+ $(this).attr("value")+ '&questionid='+ $(this).attr("questionid")+ '&type=sub&subtype=pending';
	  $.ajax({
	        	dataType: "html",
	            url: 'QuestionWatch', // Get the action URL to send AJAX to
	            type: "POST",
	            data: data, // get all form variables
	            success: function(result){
	            		$(".rightcontainer").html(result);   	
	            }
	        });
	    });
		
		
    
    
    $(".pendingbutton").on("click", function (event) {
        event.preventDefault();
        var data = '&menutype=pending';
  $.ajax({
        	dataType: "html",
            url: 'QuestionMain', // Get the action URL to send AJAX to
            type: "GET",
            data: data, // get all form variables
            success: function(result){
            		$(".middlecontainer").html(result);   	
            }
        });
	$.ajax({
		type: "GET",
		cache:false,
		url:"QuestionSub",
		data:'&subtype=current',
		success:function(response){
			$(".leftcontainer").html(response);
		}
	})
	
	$.ajax({
	type: "GET",
	cache:false,
	url:"QuestionSub",
	data:'&subtype=archive',
	success:function(response){
		$(".rightcontainer").html(response);
	}
})
  
  
  
    });
});

	
</script>



</html>