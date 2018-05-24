package qofd.SystemInterfaces;

import java.sql.SQLException;
import java.util.List;

import qofd.Models.Question;


public interface QuestionDAOI {

	
	public List<Question> getAllQuestion() throws SQLException;
	public List<Question> getTodaysQuestion() throws SQLException;
	public Question getQuestion(int question_id) throws SQLException;
	
}
