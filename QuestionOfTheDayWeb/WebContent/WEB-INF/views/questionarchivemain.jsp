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
<%@ page import = "java.util.Calendar" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<spring:url value="/resources/images/watch.svg" var="followicon" />
<spring:url value="/resources/images/unwatch.svg" var="unfollowicon" />
</head>

<%! QuestionDAO qDAO = new QuestionDAO();%>
<%! OptionDAO oDAO = new OptionDAO();%>
<%! UserChoicesDAO ucDAO = new UserChoicesDAO(); %>
<%! UserWatchingDAO uwDAO = new UserWatchingDAO(); %>


<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.0");
SimpleDateFormat monthformat = new SimpleDateFormat("MMM-dd-yyyy hh:mm");
Calendar cal = Calendar.getInstance();
 %>



<% 

User user = new User();

if(session.getAttribute("user") != null)
	user = (User) session.getAttribute("user");

%>

<body>
<div class = 'archive'>
<h1 class = middlecontainerHeading>
<%

String sort = request.getParameter("sort");
String Page = request.getParameter("page");


if(sort == null || sort == "date")
	sort = "date";
if(Page == null)
	Page = "1";

out.print("Archived Questions");

if(sort.equals("date"))
{
	
	
		cal.add(Calendar.DATE, -(Integer.parseInt(Page)+6));
	
	
	
	
		out.print("<div type= 'button' class='pagebutton' sort='rank' value ='1'>Sort by rank </div>");
		out.print("<br>");
		out.print("<div class='pageClicker'>");
		out.print("<input type= 'button' class='pagebutton' sort='date' value ='1'/>");
		out.print("<input type= 'button' class='pagebutton' sort='date' value ='2'/>");
		out.print("<input type= 'button' class='pagebutton' sort='date' value ='3'/>");
		out.print("<input type= 'button' class='pagebutton' sort='date' value ='4'/>");
		out.print("<input type= 'button' class='pagebutton' sort='date' value ='5'/>");
		out.print("<input type= 'button' class='pagebutton' sort='date' value ='6'/>");
		out.print("<input type= 'button' class='pagebutton' sort='date' value ='7'/>");
		out.print("</div>");

	
}

else if(sort.equals("rank"))
{

	out.print("<div type= 'button' class='pagebutton' sort='date' value ='1'>Sort by date </div>");
	out.print("<br>");
	out.print("<div class='pageClicker'>");
	out.print("<input type= 'button' class='pagebutton' sort='rank' value ='1'/>");
	out.print("<input type= 'button' class='pagebutton' sort='rank' value ='2'/>");
	out.print("<input type= 'button' class='pagebutton' sort='rank' value ='3'/>");
	out.print("<input type= 'button' class='pagebutton' sort='rank' value ='4'/>");
	out.print("<input type= 'button' class='pagebutton' sort='rank' value ='5'/>");
	out.print("<input type= 'button' class='pagebutton' sort='rank' value ='6'/>");
	out.print("<input type= 'button' class='pagebutton' sort='rank' value ='7'/>");
	out.print("</div>");
	


}

%>
</h1>
</div>

<%


	int dateOffset = Integer.parseInt(Page);
	
List<Question> QuestionList = null;
HashMap<Integer,List<Option>> topOption= null;
HashMap<Integer,Integer> userChoices = null; 
HashMap<Integer, User> creatorList= null;


QuestionList = (List<Question>) pageContext.getAttribute("QuestionList", PageContext.REQUEST_SCOPE);
topOption = (HashMap<Integer,List<Option>>) pageContext.getAttribute("topOption", PageContext.REQUEST_SCOPE);
userChoices = (HashMap<Integer,Integer>) pageContext.getAttribute("userChoices", PageContext.REQUEST_SCOPE);
creatorList = (HashMap<Integer, User> ) pageContext.getAttribute("creatorList", PageContext.REQUEST_SCOPE);

	

	
	 
	for(Question q: QuestionList)
	{
		User creator = creatorList.get(q.getUser_id());

		int chosen = 0;
		if(userChoices.containsKey(q.getQuestion_id()))
		{		
		chosen = userChoices.get(q.getQuestion_id());
		}
		
		out.print("<div class = 'Questionformcontainer' style= 'border-color:red;'>");
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
			<button class='followbutton' type= 'submit' name='questionbutton' value ='Submit'>
			<img class='followicon' src="${unfollowicon}">
			</button>
			
			<% 
			
			
		}
		
		out.print("</span>" );
		out.print("</div>");
		
		out.print("<div class = 'containerrightheader'> "+  monthformat.format(sdf.parse(q.getDate()))  + "</div>");

		out.print("</div>");
		
		out.print("<p> <a class = 'archive' href ='Questions?&questionid=" + q.getQuestion_id()+ "'>" + q.getQuestion_text() + "</a></p>");
		
		
		out.print("<div class= 'QuestionChoiceContainer'>");

		for(Option option:topOption.get(q.getQuestion_id()))
		{
			out.print("<div class = 'QuestionChoices'>");

			
			if(chosen == option.getOptions_id())
			{
				
			out.print("<input type='radio' name = 'rankoptionquestion" + q.getQuestion_id()+"' value = '" + option.getOptions_id() + "' disabled='disabled' checked> "+ option.getOption_text());
			out.print("!");}
			else{
			out.print("<input type='radio' name = 'rankoptionquestion" + q.getQuestion_id()+"' value = '" + option.getOptions_id() + "' disabled>"+ option.getOption_text());
			}
				
			out.print(" " + option.getOption_score());
			
			out.print("</div>");

		}
		out.print("</div>");
		out.print("</div>");
		

		
	}

	
%>


</body>



<script>

$(document).ready(function(){
    $(".pagebutton").on("click", function (event) {
        event.preventDefault();
        var data = '&page='+ $(this).attr("value")+ "&sort="+ $(this).attr("sort")+ "&menutype=archive";
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
	
	
});
	
</script>



</body>
</html>