package springwork.controller;
import qofd.Dao.*;
import qofd.Models.*;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import helperfunction.MavHelperFunction;

@Controller
public class HomeController {
	@RequestMapping("/")
	public ModelAndView HomePage()  {
		
		ModelAndView mav = new ModelAndView("HomePage");
		
		return mav;
	}
	
	@RequestMapping(value="/Login", method = RequestMethod.POST)
	public ModelAndView LoginPage(HttpServletRequest request) throws SQLException {
		ModelAndView mav = null;;
		UserDAO uDAO = new UserDAO();
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		User user = uDAO.loginUser(email, password);
		
		
		if(user != null)
		{
			mav = new ModelAndView("redirect:/");
			request.getSession().setAttribute("user", user);
		}
		else
		{
			mav = new ModelAndView("DashBoard");
			mav.addObject("loginmessage", "Username And Password did not match");
			
		}
			
		
		return mav;
	}
	
	@RequestMapping(value="/Register", method = RequestMethod.POST)
	public ModelAndView Resgister(HttpServletRequest request) throws SQLException {
		ModelAndView mav = new ModelAndView("HomePage");
		UserDAO uDAO = new UserDAO();
		String first_name = request.getParameter("firstname");
		String last_name = request.getParameter("lastname");
		String email = request.getParameter("registeremail");
		String password = request.getParameter("registerpassword");
		User user = new User( email,  password,  first_name,  last_name);
		
		int id = uDAO.registerUser(user);
		
		if(id == 0)
			mav.addObject("message", "Username Or Password Already Exists");
		else
			mav.addObject("message", "Register Sucessful you may log in");
			
		
		return mav;
	}
	
	
	@RequestMapping("/LogOut")
	public ModelAndView LogOut(HttpServletRequest request)  {
		
		request.getSession().invalidate();
		ModelAndView mav = new ModelAndView("redirect:/");
		
		return mav;
	}
	
	
	@RequestMapping("/DashBoard")
	public ModelAndView DashBoard()  {
		
		ModelAndView mav = new ModelAndView("DashBoard");
		
		return mav;
	}
	
	@RequestMapping("/UserPage")
	public ModelAndView UserPage(HttpServletRequest request) throws SQLException  {
		
		UserDAO uDAO = new UserDAO();
		User user = (User) request.getSession().getAttribute("user");
		int[] following = uDAO.getUserFollowing(user.getUser_id());
		User userinformation = uDAO.getUser(user.getUser_id());
		ModelAndView mav = new ModelAndView("userpage");
		mav.addObject("following",following);
		mav.addObject("userinformation",userinformation);
		
		return mav;
	}
	
	@RequestMapping("/UserInformation")
	public ModelAndView UserInformation(HttpServletRequest request) throws SQLException  {
		
		UserDAO uDAO = new UserDAO();
		User user = (User) request.getSession().getAttribute("user");
		int[] following = uDAO.getUserFollowing(user.getUser_id());
		User userinformation = uDAO.getUser(user.getUser_id());
		ModelAndView mav = new ModelAndView("userinformation");
		mav.addObject("following",following);
		mav.addObject("userinformation",userinformation);
		
		return mav;
	}

	@RequestMapping("/Questions")
	public ModelAndView Questions(HttpServletRequest request) throws NumberFormatException, SQLException, ParseException  {
		
		ModelAndView mav = new ModelAndView("Questions");
		
		return mav;
	}
	
	@RequestMapping("/Question")
	public ModelAndView Question(HttpServletRequest request) throws NumberFormatException, SQLException, ParseException  {
		
		ModelAndView mav = MavHelperFunction.getQuestion(request);
		return mav;
	}
	
	
	@RequestMapping("/QuestionMain")
	public ModelAndView QuestionMain(HttpServletRequest request ) throws SQLException  {
		
		ModelAndView mav = MavHelperFunction.getQuestionMain(request);
		
		System.out.println();
		System.out.println("Delivering things");

		
		

		return mav;
	}
	
	@RequestMapping("/QuestionSub")
	public ModelAndView QuestionSub(HttpServletRequest request ) throws SQLException  {
		
		ModelAndView mav = MavHelperFunction.getQuestionSub(request);
		

		
		return mav;
	}
	
	@RequestMapping(value="/QuestionMainChoice", method = RequestMethod.POST)
	public ModelAndView QuestionMainChoice(HttpServletRequest request ) throws SQLException  {
		
		ModelAndView mav = null;
		
		User user = (User) request.getSession().getAttribute("user");
		UserChoicesDAO ucDAO = new UserChoicesDAO();

		int questionid = 0;
		int optionid = 0;
		String requestqid =  request.getParameter("questionid");
		String requestoid =  request.getParameter("optionid");
		
		
		if(requestqid != null)
			questionid = Integer.parseInt(requestqid);
		if(requestoid != null)
			optionid = Integer.parseInt(requestoid);
		
		
		int userid = user.getUser_id();
		
		int userchoice = ucDAO.getUserQChoice(userid, questionid);	
		
		if(optionid != 0)
		{
			if(userchoice == 0)
				ucDAO.createUserChoice(userid, questionid, optionid);
			else
				ucDAO.changeUserChoice(userid, questionid, userchoice, optionid);
		}
		else
		{
			if(userchoice != 0)
				ucDAO.deleteUserChoice(userid, questionid, userchoice);
		}
		
		
		System.out.println(optionid + " completed - returning");
		
		String type = request.getParameter("type");
		if(type == null || type.equals("main"))
		 mav = MavHelperFunction.getQuestionMain(request);
		
		else
		 mav = MavHelperFunction.getQuestionSub(request);

		return mav;
	}
	
	@RequestMapping(value="/ChooseCurrent", method = RequestMethod.POST)
	public ModelAndView ChooseCurrent(HttpServletRequest request ) throws SQLException, ParseException  {
		
		ModelAndView mav = null;
		
		User user = (User) request.getSession().getAttribute("user");
		UserChoicesDAO ucDAO = new UserChoicesDAO();

		int questionid = 0;
		int optionid = 0;
		String requestqid =  request.getParameter("questionid");
		String requestoid =  request.getParameter("optionid");
		
		System.out.println(requestqid + requestoid);
		
		if(requestqid != null)
			questionid = Integer.parseInt(requestqid);
		if(requestoid != null)
			optionid = Integer.parseInt(requestoid);
		
		
		int userid = user.getUser_id();
		int userchoice = ucDAO.getUserQChoice(userid, questionid);	
		
		System.out.println(questionid+ " " + optionid + " " + userchoice + " " + userid);
		if(optionid != 0)
		{
		if(userchoice == 0)
			ucDAO.createUserChoice(userid, questionid, optionid);
		else
			ucDAO.changeUserChoice(userid, questionid, userchoice, optionid);
		}
		else
		{
			if(userchoice != 0)
				ucDAO.deleteUserChoice(userid, questionid, userchoice);
		}
		
			 mav = MavHelperFunction.getQuestion(request);

		return mav;
	}
	
	@RequestMapping(value="/WatchPending", method = RequestMethod.POST)
	public ModelAndView WatchPending(HttpServletRequest request ) throws SQLException, ParseException  {
		
		ModelAndView mav = null;
		UserWatchingDAO uwDAO = new UserWatchingDAO(); 
		User user = (User) request.getSession().getAttribute("user");

		int questionid = 0;
		String requestqid =  request.getParameter("questionid");
		
		
		if(requestqid != null)
			questionid = Integer.parseInt(requestqid);
		int userid = user.getUser_id();
		
	
		
		String watching = null;
		watching = request.getParameter("watching");
		
		
		System.out.println("watching ="+  watching + " userid = " + userid + "questionid=" + questionid) ;
	
		if(watching.equals("UnWatch"))
			uwDAO.unwatch(user.getUser_id(), questionid);
		else
			uwDAO.watch(user.getUser_id(), questionid);
	

		
			 mav = MavHelperFunction.getQuestion(request);

		return mav;
	}
	
	@RequestMapping(value="/SubmitComment", method = RequestMethod.POST)
	public ModelAndView SubmitComment(HttpServletRequest request ) throws SQLException, ParseException  {
		
		ModelAndView mav = null;
		
		User user = (User) request.getSession().getAttribute("user");
		UserChoicesDAO ucDAO = new UserChoicesDAO();
		CommentDAO cDAO = new CommentDAO();

		int questionid = 0;
		int choice = 0;
		String requestqid =  request.getParameter("questionid");
		String requestchoice =  request.getParameter("choice");
		String getcomment =  request.getParameter("getcomment");
		
		
		if(requestqid != null)
			questionid = Integer.parseInt(requestqid);
		if(requestchoice != null)
			choice = Integer.parseInt(requestchoice);
		
		
		int userid = user.getUser_id();
		int userchoice = ucDAO.getUserQChoice(userid, questionid);	
		
		System.out.println(userid+ " " + questionid + " " + choice + " " + getcomment);

		cDAO.createComment(new Comments(userid, questionid, choice, getcomment));
		
			 mav = MavHelperFunction.getQuestion(request);

		return mav;
	}
	
	@RequestMapping(value="/QuestionWatch", method = RequestMethod.POST)
	public ModelAndView QuestionWatch(HttpServletRequest request ) throws SQLException  {
		
		System.out.println("completed - returning");
		
		ModelAndView mav = null;
		
		UserWatchingDAO uwDAO = new UserWatchingDAO();
			
		User user = (User) request.getSession().getAttribute("user");

		int userid = user.getUser_id();
		
		int questionid = 0;
		String requestqid =  request.getParameter("questionid");
		
		String watching = null;
		watching = request.getParameter("watching");
		
		if(requestqid != null)
			questionid = Integer.parseInt(requestqid);
		
		System.out.println("watching ="+  watching + " userid = " + userid + "questionid=" + questionid) ;
	
		if(watching.equals("UnWatch"))
			uwDAO.unwatch(user.getUser_id(), questionid);
		else
			uwDAO.watch(user.getUser_id(), questionid);
	
		String type = request.getParameter("type");
		if(type == null || type.equals("main"))
		 mav = MavHelperFunction.getQuestionMain(request);
		
		else
		 mav = MavHelperFunction.getQuestionSub(request);

		return mav;
	}
	
	@RequestMapping(value="/CreateQuestion", method = RequestMethod.POST)
	public String CreateQuestion(HttpServletRequest request ) throws SQLException  {
		ModelAndView mav = null;
		QuestionDAO qDAO = new QuestionDAO();
		OptionDAO oDAO = new OptionDAO();
		User user = (User) request.getSession().getAttribute("user");
		
		String questiontext = request.getParameter("questiontext");
		String createoptions[] =  request.getParameterValues("optionchoice");
		int id = qDAO.createNewQuestion(user.getUser_id(), questiontext);
		if(id != 0)
			for(String option_text: createoptions)
			{
			oDAO.createOption(id, option_text);
			}
		
		String referer  = request.getHeader("referer");		
		return "redirect:"+ referer;
	}
	
	@RequestMapping(value="/QuestionInfo", method = RequestMethod.POST)
	public ModelAndView QuestionInfo(HttpServletRequest request ) throws SQLException, ParseException  {
		ModelAndView mav = null;
		QuestionDAO qDAO = new QuestionDAO();
		OptionDAO oDAO = new OptionDAO();
		UserDAO uDAO = new UserDAO();		
		
		
		
		SimpleDateFormat monthformat = new SimpleDateFormat("MMM-dd-yyyy");
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.0");
		Calendar today = Calendar.getInstance();
		
		today.add(Calendar.DATE, 1);
		today.set(Calendar.HOUR_OF_DAY, 0);
		today.set(Calendar.MINUTE,0);
		today.set(Calendar.SECOND,0);
		today.set(Calendar.MILLISECOND,0);

		int questionid = Integer.parseInt(request.getParameter("questionid"));
		Question question = qDAO.getQuestionById(questionid);
		User createdBy = uDAO.getUser(question.getUser_id());
		
		Date currentday = today.getTime();
		Date questiondate = sdf.parse(question.getDate());
	
		Long diffDays = (currentday.getTime() - questiondate.getTime()) / (1000 * 60 * 60 * 24);

		
		mav = new ModelAndView("QuestionInformation");
		mav.addObject("question", question);
		mav.addObject("createdBy", createdBy);
		mav.addObject("diffDays" , diffDays);
		if(diffDays < 1)
			mav.addObject("status", "Pending");
		else if(diffDays >= 8)
			mav.addObject("status", "Archived");
		else
			mav.addObject("status", "Current");
			
			
			
		
		
		return mav;
	}
	
	
	
	@RequestMapping(value="/UserPageFollowing", method = RequestMethod.POST)
	public ModelAndView UserPageFollowing(HttpServletRequest request ) throws SQLException, ParseException  {
		ModelAndView mav = null;
	
		mav = MavHelperFunction.getFollowingQuestions(request);
		
		
		
		return mav;
	}
	
	
	@RequestMapping(value="/UserPageChangeChoice", method = RequestMethod.POST)
	public ModelAndView UserPageChangeChoice(HttpServletRequest request ) throws SQLException, ParseException  {
		ModelAndView mav = null;
		
		User user = (User) request.getSession().getAttribute("user");
		UserChoicesDAO ucDAO = new UserChoicesDAO();

		int questionid = 0;
		int optionid = 0;
		String requestqid =  request.getParameter("questionid");
		String requestoid =  request.getParameter("optionid");
		
		if(requestqid != null)
			questionid = Integer.parseInt(requestqid);
		if(requestoid != null)
			optionid = Integer.parseInt(requestoid);
		
		
		int userid = user.getUser_id();
		
		int userchoice = ucDAO.getUserQChoice(userid, questionid);	
		
		System.out.println(questionid+ " " + optionid + " " + userchoice + " " + userid);

		
		if(optionid != 0)
		{
		ucDAO.changeUserChoice(userid, questionid, userchoice, optionid);
		
		}
		else
			
		{
			ucDAO.deleteUserChoice(userid, questionid, userchoice);
		}
		mav = MavHelperFunction.getFollowingQuestions(request);
		
		
		
		return mav;
	}
}




