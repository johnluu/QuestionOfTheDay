<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<div class= "header">

<% 

if(request.getParameter("logout") != null) 
	{
	
	session.invalidate();
	response.sendRedirect("HomePage.jsp");
	return;
	}

if(request.getParameter("createoption") != null) 
{
	String questiontext = request.getParameter("questiontext");
	String createoptions[] =  request.getParameterValues("optionchoice");
	qDAO.createNewQuestion(user.getUser_id(), questiontext, createoptions);
}

%>
	<h1> Welcome <%= user.getFirst_name() %></h1>
<form method ="post">
<input type= "submit" name="logout" value="logout" /> <br>
</form>

<div class="dropdown">
  <button onclick="myFunction()" class="dropbtn">Dropdown</button>
  <div id="myDropdown" class="dropdown-content">
        <button onclick="addOption()">Try it</button>
    	<button onclick="removeOption()" class = "removeOption">removeOption</button>
  
    <form method ="post">
    	  <textarea name="questiontext" rows="10" cols="30"></textarea>
		<div id="optionlist">
		Option 1 <input name="optionchoice" type="text" id="option1"> </input> </br>
   		Option 2 <input name="optionchoice" type="text" id="option2"> </input> </br>
   		</div>
   		<input type= "submit" name= "createoption" value ="Submit">
    </form>

  </div>
  

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
    var textnode = document.createTextNode("Option " + numoption);
    x.setAttribute("type", "text");
    x.setAttribute("name" , "optionchoice")
    x.setAttribute("id", "option" + numoption);
    
    document.getElementById("optionlist").appendChild(textnode);
    document.getElementById("optionlist").appendChild(x);
    document.getElementById("optionlist").appendChild(y);
    
    
	}

}

function removeOption() {
	if(numoption > 2)
	{
	removeoptionnum = (numoption * 3);
    var options = document.getElementById("optionlist");
	options.removeChild(options.childNodes[removeoptionnum]);
	options.removeChild(options.childNodes[removeoptionnum]);
	options.removeChild(options.childNodes[removeoptionnum]);
	numoption--;
	}
}
</script>

</div>