<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>




<html>
<head>
<spring:url value="/resources/style.css" var="stylecss" />
<link href="${stylecss}" rel="stylesheet" />

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
</head>


<%	
	if(session.getAttribute("user") != null)
	{	
		response.sendRedirect("/QuestionOfTheDayWeb/DashBoard");	
	}

	String message = request.getParameter("message");


	
	
	
%>


<body>
<%@ include file = "Header.jsp" %>

<div class ="container">


<div class = 'maincontainer'>

<div class=homeleft>


<h1>About Question of the Day</h1>

<p>  
Welcome to Questions of The Day a place to discuss popular topics and questions.
Questions have a life span of 15 days and go through three stages during their lifetime.
</p>





<h2 class ='pending'>Pending</h2>
<p> 
The first stage of a newly created question is pending, At this stage Users cannot comment on the question or pick a choice. 
You can choose to watch/unwatch a question. The top 5 questions for that day will move on to the next stage and the rest will be deleted.
This stage lasts until the end of the day.
</p>

<h2 class ='current'>Current</h2>
<p> 
The Second Stage of a question is Current. This is the stage when the question is active. Users lose the ability to watch a question.
Users are able follow/unfollow questions and comment on the them.
 This stage lasts for a week until it gets moved on to the next stage.
</p>

<h2 class ='archive'>Archived</h2>
<p> 
The Third and Last Stage of a question when it becomes Archived. At this stage the questions becomes static. Users won't be able to
watch/unwatch, follow/unfollow or comment on the question. The only thing you could do at this stage is view the state it was in
before it was archived. This stage lasts a week until the question is deleted.
</p>


</div>




<div class = "homeright">
<h1>Register Now</h1>
${message}
<form class="registerform" action= "Register" method = "post">
Email <input type="email" name="registeremail" placeholder='Email' required/> <br/>
First Name <input type = "text" name ="firstname"  placeholder='FirstName' required/><br/>
Last Name<input type="text" name="lastname"  placeholder='LastName' required/> <br/>
Password <input id="password" name="password" oninput="setCustomValidity('') oninvalid="setCustomValidity('Password not strong enough: Needs to be at least 6 character, 1 uppercase, 1 lowercase, 1 number')" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" type = "password" name ="registerpassword"  placeholder='Password' required/><br/>
Confirm Password <input oninput="check(this)" type = "password" name ="registerpassword"  placeholder='Confirm Password' required/><br/>
<input type= "submit" name="register" value="register" /> <br>
</form>

</div>

</div>
</div>
<div class = footer> @Copyright blahblahblah</div>


</body>

<script>
    function check(input) {
        if (input.value != document.getElementById('password').value) {
            input.setCustomValidity('Password Must be Matching.');
        } else {
            // input is valid -- reset the error message
            input.setCustomValidity('');
        }
    }
</script>

</html>