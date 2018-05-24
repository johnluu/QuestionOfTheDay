<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import = "qofd.Dao.UserDAO" %>
<%@ page import = "qofd.Models.User" %>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
</head>
<%! UserDAO userdao = new UserDAO(); %>


<%	
	if(session.getAttribute("user") != null)
		response.sendRedirect("DashBoard.jsp");

	String message = null;

	if(request.getParameter("login") != null)
	{
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	User user = userdao.loginUser(email, password);

	if(user != null){
		message = "SUCCESSFUL LOGIN";
		session.setAttribute("user", user);
		response.sendRedirect("DashBoard.jsp");
	}else {
		message = "Password and Username does not match";
	}
}
	if(request.getParameter("register") != null)
	{
	
	String email = request.getParameter("registeremail");
	String password = request.getParameter("registerpassword");
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	User user = new User(email,password,firstname,lastname);
	int id = userdao.registerUser(user);

	if(id != 0){
		message = "SUCCESSFUL Register";
		user.setUser_id(id);
		session.setAttribute("user", user);
		response.sendRedirect("DashBoard.jsp");
	}else {
		message = "Failed to create user";
	}
}
	
	
%>


<body>


<%
	if(message != null)
		out.print("<span style='color:red'>" + message + "</span>");
%>
<form method = "post">
Email<input type = "text" name ="email" />
<br/>
Password<input type="text" name="password" /> <br/>
<input type= "submit" name="login" value="Login" />
</form>

<form method = "post">
Email <input type="text" name="registeremail" /> <br/>
First Name <input type = "text" name ="firstname" /><br/>
Last Name<input type="text" name="lastname" /> <br/>
Password <input type = "text" name ="registerpassword" /><br/>
<input type= "submit" name="register" value="register" /> <br>
</form>


</body>
</html>