package qofd.SystemInterfaces;

import java.sql.SQLException;
import java.util.List;

import qofd.Models.Question;


public interface QuestionDAOI {

	
	int createNewQuestion(int userid, String questiontext) throws SQLException;
	List<Question> getQuestionByDate(int dateOffset) throws SQLException;
	List<Question> getQuestionByRank(int rowOffset) throws SQLException;
	Question getQuestionById(int question_id) throws SQLException;
	List<Question> getArchiveQuestionByRank(int rowOffset) throws SQLException;
	List<Question> getPendingByRank(int rowOffset) throws SQLException;
	List<Question> getPendingByDate(int rowOffset) throws SQLException;
	boolean deleteQuestion(int questionid) throws SQLException;
	int getPendingCount() throws SQLException;
	List<Question> getFollowingQuestionsByDate(int userid, int rowOffset) throws SQLException;
	List<Question> getFollowingQuestionsByRank(int userid, int rowOffset) throws SQLException;
	
}
