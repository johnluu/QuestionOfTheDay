package qofd.MainEntry;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import qofd.Dao.NewOptionsDAO;
import qofd.Dao.NewQuestionDAO;
import qofd.Dao.QuestionDAO;
import qofd.Dao.UserChoicesDAO;
import qofd.Dao.UserDAO;
import qofd.Dao.UserWatchingDAO;
import qofd.Models.New_Option;
import qofd.Models.New_Question;
import qofd.Models.Question;
import qofd.Models.User;

public class Test {

	public static void main(String[] args) throws SQLException {

		UserDAO userDAO = new UserDAO();
		
//		User user = new User("John@gmail.com", "CALAHAM", "john", "Luu");
//		userDAO.registerUser(user);
		
//		User user = userDAO.loginUser("Jon@gmail.com", "CALAHAM");
//		
//		if(user != null)
//		System.out.println(user.getFirst_name());
//		else
//		System.out.println("Invalid pass");
		
//		User user = userDAO.getUser(1);
//		System.out.println(user.getFirst_name());
//		
//		NewQuestionDAO nqDAO = new NewQuestionDAO();
//		nqDAO.createNewQuestion(1, "This is a new question",new String[] {"a","b","C"});
//		List<New_Question> newQLIST = nqDAO.getAllNewQuestion();
//		
//		for(New_Question a: newQLIST)
//		{
//			System.out.println(a.getQuestion_id() + " " + a.getQuestion_text());
//		}
////		
//		
//		New_Question q = nqDAO.getnewQuestion(11);
//		NewOptionsDAO opDAO = new NewOptionsDAO();
//		List<New_Option> nOp = opDAO.getNewQuestionOption(11);
//		System.out.println(q.getQuestion_id() + " " + q.getQuestion_text());
//		for(New_Option a: nOp)
//			System.out.println(a.getOptions_id() + " " + a.getOption_text());
//		
//		
//		UserWatchingDAO u = new UserWatchingDAO();
//		
//		u.watch(1, 1);
//		u.watch(1, 2);
//		u.watch(1, 3);
//		
//		HashSet<Integer> iswatching = u.isWatching(1);
//		
//		for(int x: iswatching)
//			System.out.println(x);
//		
//		u.unwatch(1, 1);
//		u.unwatch(1, 2);
//		u.unwatch(1, 3);
//		
//		
//		iswatching = u.isWatching(1);
//		
//		System.out.println("THings");
//		for(int x: iswatching)
//			System.out.println(x);

//		New_Question wachquestion = nqDAO.getnewQuestion(1);
//		System.out.println(wachquestion.getWatches());
//		QuestionDAO QDAO = new QuestionDAO();
//		Question q = null;
//		List<Question> qList;
//		
//		qList = QDAO.getTodaysQuestion();
//		for(Question z: qList)
//			System.out.println( z.getQuestion_id() + " " + z.getQuestion_text() + " " + z.getDate());
//		
//		q = QDAO.getQuestion(6);
//		
//		System.out.println(q.getQuestion_id() + " " + q.getQuestion_text() + " " + q.getDate());
		
		UserChoicesDAO uod = new UserChoicesDAO();
		
		
		
		HashMap<Integer,Integer> userChoices = uod.getUserChoice(1);
		
		
		
		System.out.println("Question Id: OPTION ID");
		userChoices.forEach((k,v) -> {
			System.out.println(k + "  " + v);
		});
//	
	}

}
