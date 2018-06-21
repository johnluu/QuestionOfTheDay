<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<div class= "header">

<spring:url value="/resources/images/logout.svg" var="logouticon" />
<spring:url value="/resources/images/dashboard.svg" var="dashicon" />
<spring:url value="/resources/images/userinfo.svg" var="usericon" />
<spring:url value="/resources/images/createquestion.svg" var="createicon" />
<spring:url value="/resources/images/logo.svg" var="logo" />

<a href= 'DashBoard'>
<div class ="logocontainer">
<div class ="logo">
<div class = "logotext" ><h1>Questions</h1> </div>
<image class="logoimage"src="${logo}"> </image> 
<div class = "logotext" ><h1>Of The Day</h1> </div>
</div>
</div>
</a>


<div class= "navbar">

<%	
	if(session.getAttribute("user") != null)
	{
%>
<div class="dropdown">
  <div onclick="myFunction()" class="dropbtn"><image class = "icon" src="${createicon}"> </image></div>
  <div id="myDropdown" class="dropdown-content">

  
    <form method ="post" action = "CreateQuestion" required>
   	  <textarea class="createformtext" name="questiontext" maxlength="150" rows="10" cols="30" placeholder="Enter Question Here" required></textarea>
		<div id="optionlist">
		<input name="optionchoice" type="text" id="option1" maxlength="10" placeholder="Option1" required> </input> </br>
   		<input name="optionchoice" type="text" id="option2" maxlength="10" placeholder="Option2" required> </input> </br>
   		</div>
   		<input type= "submit" name= "createoption" value ="Submit">
   		        <button type="button" onclick="addOption()">add</button>
    	<button type="button" onclick="removeOption()" class = "removeOption">remove</button>
    </form>
  </div>
</div>
<div>


<a href = 'DashBoard'>
	<image class = "icon" src="${dashicon}"> </image>
</a>
<a href = 'UserPage'>
	<image class = "icon" src="${usericon}"> </image>
</a>

</div>




<div>
<form method ="post" action ="LogOut">
<input type= "image" class = "icon" src="${logouticon}" />
</form>
</div>

<%	
	}
	else
	{
%>

<p>${loginmessage} </p>
<form action ="Login" method = "POST">
<div class = "logincontainer">
<div class = "logininput">
<div>Email</div>
<input type = "email" name ="email" />
</div>
<div class = "logininput">
<div>Password</div>
<input type="password" name="password" />
</div>

<input class ="loginsubmit" type= "submit" name="submit" value="Login" />

</div>
</form>


<%	
	}
%>



</div>

<script>
var numoption = 2; 
/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it

function addOption() {
	if(numoption < 10)
		{
		numoption++;
    var x = document.createElement("INPUT");
    var y = document.createElement("BR");
    x.setAttribute("type", "text");
    x.setAttribute("name" , "optionchoice")
    x.setAttribute("placeholder","Option" + numoption);
    x.setAttribute("id", "option" + numoption);
    x.setAttribute("maxlength", "10");

    x.setAttribute("required", "required");
    
    document.getElementById("optionlist").appendChild(x);
    document.getElementById("optionlist").appendChild(y);
    
    console.log(numoption) 

	}
	
}
function removeOption() {
	if(numoption > 2)
	{
    var options = document.getElementById("optionlist");
	options.removeChild(options.lastChild);
	options.removeChild(options.lastChild);
	numoption--;
	}
}



</script>

</div>