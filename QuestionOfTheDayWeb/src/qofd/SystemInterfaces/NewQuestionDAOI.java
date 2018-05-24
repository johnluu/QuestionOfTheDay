package qofd.SystemInterfaces;

import java.sql.SQLException;
import java.util.List;

import qofd.Models.New_Question;

public interface NewQuestionDAOI {

	public New_Question getnewQuestion(int questionid) throws SQLException;
	public List<New_Question> getAllNewQuestion();
	public List<New_Question> getTopNewQuestion() throws SQLException;
	public boolean createNewQuestion(int userid,String questiontext, String[] option) throws SQLException;
	
	
}
