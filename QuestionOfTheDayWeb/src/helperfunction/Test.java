package helperfunction;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import qofd.Dao.OptionDAO;
import qofd.Dao.QuestionDAO;
import qofd.Dao.UserChoicesDAO;
import qofd.Models.Option;
import qofd.Models.Question;

public class Test {

	public static void main(String[] args) throws SQLException {
		// TODO Auto-generated method stub
		QuestionDAO qDAO = new QuestionDAO();
		OptionDAO oDAO = new OptionDAO();
		UserChoicesDAO ucDAO = new UserChoicesDAO();
		List<Question> QuestionList = null;
		HashMap<Integer, List<Option>> topOption= null;
		HashMap<Integer,Integer> userChoices = null; 
		
		
		QuestionList = qDAO.getArchiveQuestionByRank(1);
		topOption = oDAO.getArchiveOptionsByRank(1);
		userChoices = ucDAO.getUserChoice(1);
		
		
		for(Question q:QuestionList)
			System.out.println(q.getDate() );
	}

}
