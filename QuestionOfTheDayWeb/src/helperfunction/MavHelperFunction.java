package helperfunction;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import qofd.Dao.CommentDAO;
import qofd.Dao.OptionDAO;
import qofd.Dao.QuestionDAO;
import qofd.Dao.UserChoicesDAO;
import qofd.Dao.UserDAO;
import qofd.Dao.UserWatchingDAO;
import qofd.Models.Comments;
import qofd.Models.Option;
import qofd.Models.Question;
import qofd.Models.User;

public class MavHelperFunction {

	public static ModelAndView getQuestionMain(HttpServletRequest request ) throws SQLException  {
		
		
		ModelAndView mav= null;
		
		String type = request.getParameter("menutype");
		if(type == null || type.equals("current"))
		{		type ="current";
				mav = new ModelAndView("questionmain");
		}
		else if(type.equals("archive"))
				mav = new ModelAndView("questionarchivemain");
		
		else if(type.equals("pending"))
			mav = new ModelAndView("pendingquestionmain");
			
		
		
		User user = (User) request.getSession().getAttribute("user");
		QuestionDAO qDAO = new QuestionDAO();
		OptionDAO oDAO = new OptionDAO();
		UserDAO uDAO = new UserDAO();
		UserChoicesDAO ucDAO = new UserChoicesDAO();
		UserWatchingDAO uwDAO = new UserWatchingDAO();
		List<Question> QuestionList = null;
		HashMap<Integer, List<Option>> topOption= null;
		HashMap<Integer,Integer> userChoices = null; 
		HashSet<Integer> userWatching = null;
		String sort = request.getParameter("sort");
		HashMap<Integer, User> creatorList = null;
		
		
		if(sort == null || sort.equals("date"))
			sort = "date";
		else if (sort.equals("rank"))
			sort = "rank";
		
		String Page = request.getParameter("page");
		if(Page == null)
			Page = "1";

		
		int Offset = Integer.parseInt(Page);

		System.out.println("type= " + type +" sort= " + sort + " page = " + Page + " Offset =" + Offset);
		
		
		
			if(sort.equals("date"))
			{	
			
				if(!type.equals("pending"))
				{
					
					if(type.equals("archive"))
						Offset = Offset + 7;
					
				QuestionList = qDAO.getQuestionByDate(Offset);
				topOption = oDAO.getOptionByDate(Offset);
				userChoices = ucDAO.getUserChoice(user.getUser_id());
				creatorList =  uDAO.getCreatorListByDates(Offset);
				}
				else
				{
					QuestionList= qDAO.getPendingByDate(Offset);
					topOption = oDAO.getPendingOptionsByDate(Offset);
					userWatching = uwDAO.isWatching(user.getUser_id());
					int pendingCount = qDAO.getPendingCount();
					creatorList =  uDAO.getCreatorListPendingByDate(Offset);

					mav.addObject("pendingCount", pendingCount);
					mav.addObject("userWatching", userWatching);


				}
					

			}
			else if (sort.equals("rank"))
			{
				if(type.equals("current"))
				{
					QuestionList = qDAO.getQuestionByRank(Offset);
					topOption = oDAO.getOptionsByRank(Offset);
					userChoices = ucDAO.getUserChoice(user.getUser_id());
					creatorList =  uDAO.getCreatorListByRank(Offset);

				}
				else if(type.equals("archive"))
				{
					
					QuestionList = qDAO.getArchiveQuestionByRank(Offset);
					topOption = oDAO.getArchiveOptionsByRank(Offset);
					userChoices = ucDAO.getUserChoice(user.getUser_id());
					creatorList =  uDAO.getCreatorListArchiveByRank(Offset);

					
				}
				
				else if(type.equals("pending"))
				{
					
					QuestionList= qDAO.getPendingByRank(Offset);
					topOption = oDAO.getPendingOptionsByRank(Offset);
					userWatching = uwDAO.isWatching(user.getUser_id());
					creatorList =  uDAO.getCreatorListPendingByRank(Offset);
					int pendingCount = qDAO.getPendingCount();
					mav.addObject("userWatching", userWatching);
					mav.addObject("pendingCount", pendingCount);

					
				}
				
				
			}
		
		for(Question q:QuestionList)
			System.out.println(q.getQuestion_id());
			
		mav.addObject("sort", sort);
		mav.addObject("page", Page);
		mav.addObject("QuestionList", QuestionList);
		mav.addObject("topOption",topOption);
		mav.addObject("userChoices",userChoices);
		mav.addObject("creatorList",creatorList);
		
		return mav;
	}
	
	public static ModelAndView getQuestionSub(HttpServletRequest request ) throws SQLException  {
		

		
		int offset = 1;
		ModelAndView mav= null;
		
		String type = request.getParameter("subtype");
		if(type == null || type.equals("current"))
		{		offset = 1;
				mav = new ModelAndView("questionsub");
		}
		else if(type.equals("archive"))
		{		offset = 8;
				mav = new ModelAndView("questionarchivesub");
				
		}
		
		else if(type.equals("pending"))
			mav = new ModelAndView("pendingquestionsub");
				

		
		User user = (User) request.getSession().getAttribute("user");
		QuestionDAO qDAO = new QuestionDAO();
		UserChoicesDAO ucDAO = new UserChoicesDAO();
		List<Question> QuestionList = null;
		UserWatchingDAO uwDAO = new UserWatchingDAO();
		HashMap<Integer,Integer> userChoices = null; 
		HashSet<Integer> userWatching = null;

		
		System.out.println();
		System.out.println("Delivering sub menu things");
		System.out.println(type);

		if(!type.equals("pending"))
		{
				QuestionList = qDAO.getQuestionByDate(offset);
				userChoices = ucDAO.getUserChoice(user.getUser_id());
		}
		else
		{
			QuestionList= qDAO.getPendingByDate(offset);
			userWatching = uwDAO.isWatching(user.getUser_id());
			mav.addObject("userWatching", userWatching);
		}
			
			

		
		mav.addObject("QuestionList", QuestionList);
		mav.addObject("userChoices",userChoices);
		
		return mav;
	}
	
	public static ModelAndView getQuestion(HttpServletRequest request) throws SQLException, ParseException  {


		
		ModelAndView mav = null;
		
		QuestionDAO qDAO = new QuestionDAO();
		OptionDAO oDAO = new OptionDAO();
		UserChoicesDAO ucDAO = new UserChoicesDAO();
		CommentDAO cDAO = new CommentDAO();
		UserDAO uDAO = new UserDAO();

		Question question = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.0");
		

		List<Option> options = null;
		int choice = 0;
		User user = (User) request.getSession().getAttribute("user");

		int questionid = Integer.parseInt(request.getParameter("questionid"));
		
		
		question = qDAO.getQuestionById(questionid);
		choice = ucDAO.getUserQChoice(user.getUser_id(), question.getQuestion_id());
		options = oDAO.getOptionsByQuestionId(question.getQuestion_id());
		List<Comments> commentList = cDAO.getQuestionComments(questionid);



		Calendar today = Calendar.getInstance();
		
		today.add(Calendar.DATE, 1);
		today.set(Calendar.HOUR_OF_DAY, 0);
		today.set(Calendar.MINUTE,0);
		today.set(Calendar.SECOND,0);
		today.set(Calendar.MILLISECOND,0);

		
		Date currentday = today.getTime();
		
		
		
		
		
		Date questiondate = sdf.parse(question.getDate());
		
		System.out.println(currentday.toString());
		System.out.println(questiondate.toString());

		
		Long diffDays = (currentday.getTime() - questiondate.getTime()) / (1000 * 60 * 60 * 24);
		
		System.out.println(diffDays);
		System.out.println((currentday.getTime() - questiondate.getTime()));

		User creator = uDAO.getUser(question.getUser_id());

		

		
		if(diffDays < 1)
		{
			mav = new ModelAndView("pendingquestion");
			UserWatchingDAO uwDAO = new UserWatchingDAO();
			HashSet<Integer> userWatching = uwDAO.isWatching(user.getUser_id());
			Integer watchCount = uwDAO.getWatchCount();
			mav.addObject("userWatching", userWatching);
			mav.addObject("watchCount", watchCount);
			
		}
		
		else if(diffDays >= 8)
		{
			mav = new ModelAndView("archivedquestion");
			HashMap<Integer,User> commentUsers = null;
			commentUsers = uDAO.getCommentUsers(questionid);
			
			mav.addObject("commentUsers", commentUsers);

		}
		
		else
		{
			mav = new ModelAndView("currentquestion");

			HashMap<Integer,User> commentUsers = null;
			commentUsers = uDAO.getCommentUsers(questionid);
			mav.addObject("commentUsers", commentUsers);

			
		}
		
		mav.addObject("creator", creator);
		mav.addObject("question", question);
		mav.addObject("choice", choice);
		mav.addObject("options",options);
		mav.addObject("commentList",commentList);

		
		return mav;
	}
	
	public static ModelAndView getFollowingQuestions(HttpServletRequest request) throws SQLException, ParseException  {
	
		ModelAndView mav = null;
		QuestionDAO qDAO = new QuestionDAO();
		OptionDAO oDAO = new OptionDAO();
		UserChoicesDAO ucDAO = new UserChoicesDAO();
		UserWatchingDAO uwDAO = new UserWatchingDAO();
		UserDAO uDAO = new UserDAO();

			
		User user = (User) request.getSession().getAttribute("user");
		String Page = request.getParameter("page");
		String sort = request.getParameter("sort");
		int offset = 1;
		
		if(Page != null)
		{
			offset = Integer.parseInt(Page);
		}
		
		if(sort == null)
			sort = "date";
		
		Integer followcount = ucDAO.getFollowing(user.getUser_id());
		
		HashMap<Integer,Integer> userChoices = ucDAO.getUserChoice(user.getUser_id());
		List<Question> questionList = null;
		HashMap<Integer,List<Option>> optionList = null;
		HashSet<Integer> userWatching = uwDAO.isWatching(user.getUser_id());
		HashMap<Integer, User> creatorList= null;

		
		if(sort.equals("date"))
		{
		questionList = qDAO.getFollowingQuestionsByDate(user.getUser_id(), offset);
		optionList = oDAO.getFollowingOptionByDate(user.getUser_id(), offset);
		creatorList = uDAO.getCreatorListFollowByDate(user.getUser_id(), offset);
		}
		else
		{		
		questionList = qDAO.getFollowingQuestionsByRank(user.getUser_id(), offset);
		optionList = oDAO.getFollowingOptionByRank(user.getUser_id(), offset);
		creatorList = uDAO.getCreatorListFollowByRank(user.getUser_id(), offset);
		}
		
		mav = new ModelAndView("userpagefollowing");
		mav.addObject("questionList",questionList);
		mav.addObject("optionList", optionList);
		mav.addObject("userChoices", userChoices);
		mav.addObject("page", Page);
		mav.addObject("sort", sort);
		mav.addObject("userWatching", userWatching);
		mav.addObject("followCount", followcount);
		mav.addObject("creatorList", creatorList);


		for(Question q: questionList)
		{
			System.out.println(q.getQuestion_id());
			
			for(Option o: optionList.get(q.getQuestion_id()))
				System.out.println(o.get_question_id());
			
		}
		
	
		
		
		
		return mav;

		
	}
}
