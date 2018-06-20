<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.List" %>
<%@ page import = "qofd.Models.Question" %>
<%@ page import = "qofd.Models.User" %>
<%@ page import = "qofd.Models.Option" %>
<%@ page import="java.util.HashMap" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Calendar" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>




<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<spring:url value="/resources/images/watch.svg" var="followicon" />
<spring:url value="/resources/images/unwatch.svg" var="unfollowicon" />

</head>

<body>
<div class = inner style= "border-color:green;">


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






<div class='currentbutton'>
<div class='current'>
<h1 class = subcontainerHeading>
Current Questions
</h1>
</div>	
</div>
	

<%
	

List<Question> QuestionList = null;
HashMap<Integer,List<Option>> topOption= null;
HashMap<Integer,Integer> userChoices = null; 



	QuestionList = (List<Question>) pageContext.getAttribute("QuestionList", PageContext.REQUEST_SCOPE);
	userChoices = (HashMap<Integer,Integer>) pageContext.getAttribute("userChoices", PageContext.REQUEST_SCOPE);
		

	for(Question q: QuestionList)
	{
		int chosen = 0;
		if(userChoices.containsKey(q.getQuestion_id()))
		{		
		chosen = userChoices.get(q.getQuestion_id());
		}
		
		out.print("<div class = 'SubQuestionformcontainer'>");
		out.print("<span> Users following " + q.getQuestion_score());

		if(userChoices.containsKey(q.getQuestion_id()))
		{
			%>
			<image class='followicon' src="${followicon}"> </image> 
			<% 
		}
		else
		{
			%>
			<image class='followicon' src="${unfollowicon}"> </image> 	
			<%
			
		}
		
		out.print("</span> </br>" );
		out.print("<a class = 'current' name='question" + q.getQuestion_id() + "'" +  "href ='Questions?&questionid=" + q.getQuestion_id()+ "'>" + q.getQuestion_text() + "</a><br/>");
		
		out.print("</div>");
	}
	

%>


<script> 
$(document).ready(function(){
	

    
    $(".currentbutton").on("click", function (event) {
        event.preventDefault();
        var data = '&menutype=current';
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
		url:"/QuestionOfTheDayWeb/QuestionSub",
		data:'&subtype=archive',
		success:function(response){
			$(".leftcontainer").html(response);
		}
	})
  
	$.ajax({
	type: "GET",
	cache:false,
	url:"/QuestionOfTheDayWeb/QuestionSub",
	data:'&subtype=pending',
	success:function(response){
		$(".rightcontainer").html(response);
	}
})
  
  
    });
});

	
</script>


</div>
</body>
</html>