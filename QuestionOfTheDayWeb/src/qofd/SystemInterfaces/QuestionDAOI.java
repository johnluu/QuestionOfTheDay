package qofd.SystemInterfaces;

import java.sql.SQLException;
import java.util.List;

import qofd.Models.Question;


public interface QuestionDAOI {

	
	boolean createNewQuestion(int userid, String questiontext, String[] options) throws SQLException;
	List<Question> getQuestionByDate(int dateOffset) throws SQLException;
	List<Question> getQuestionByRank(int rowOffset) throws SQLException;
	Question getQuestionById(int question_id) throws SQLException;
	List<Question> getQuestionArchiveByDate(int dateOffset) throws SQLException;
	
}
