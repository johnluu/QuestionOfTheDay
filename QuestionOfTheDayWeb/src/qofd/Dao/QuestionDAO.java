package qofd.Dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import qofd.Models.Question;
import qofd.SystemInterfaces.QuestionDAOI;
import qofd.Utils.OracleQueries;

public class QuestionDAO implements QuestionDAOI {



	@Override
	public List<Question> getQuestionByDate(int dateOffset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List<Question> Questions = new ArrayList<Question>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Question.GETQUESTIONBYDATE);
			stmt.setInt(1, dateOffset);
			stmt.setInt(2, dateOffset);
			result = stmt.executeQuery();
			
			while(result.next())
			{
				Questions.add(new Question(result.getInt(1),result.getInt(2),result.getString(3),result.getInt(4),result.getInt(5),result.getString(6)));
			}
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(result != null)
			result.close();
		if(stmt != null)
			stmt.close();
		
		return Questions;
	}
	

	
	
	@Override
	public List<Question> getQuestionByRank(int rowOffset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List<Question> Questions = new ArrayList<Question>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Question.GETQUESTIONBYRANK);
			stmt.setInt(1, rowOffset);
			result = stmt.executeQuery();
			
			while(result.next())
			{
				Questions.add(new Question(result.getInt(1),result.getInt(2),result.getString(3),result.getInt(4),result.getInt(5),result.getString(6)));
			}
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(result != null)
			result.close();
		if(stmt != null)
			stmt.close();
		
		return Questions;
	}
	
	@Override
	public List<Question> getArchiveQuestionByRank(int rowOffset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List<Question> Questions = new ArrayList<Question>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Question.GETQUESTIONARCHIVEBYRANK);
			stmt.setInt(1, rowOffset);
			result = stmt.executeQuery();
			
			while(result.next())
			{
				Questions.add(new Question(result.getInt(1),result.getInt(2),result.getString(3),result.getInt(4),result.getInt(5),result.getString(6)));
			}
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(result != null)
			result.close();
		if(stmt != null)
			stmt.close();
		
		return Questions;
	}
	
	@Override
	public List<Question> getPendingByDate(int rowOffset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List<Question> Questions = new ArrayList<Question>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Question.GETPENDINGQUESTIONBYDATE);
			stmt.setInt(1, rowOffset);
			result = stmt.executeQuery();
			
			while(result.next())
			{
				Questions.add(new Question(result.getInt(1),result.getInt(2),result.getString(3),result.getInt(4),result.getInt(5),result.getString(6)));
			}
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(result != null)
			result.close();
		if(stmt != null)
			stmt.close();
		
		return Questions;
	}
	
	@Override
	public List<Question> getPendingByRank(int rowOffset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List<Question> Questions = new ArrayList<Question>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Question.GETPENDINGQUESTIONBYRANK);
			stmt.setInt(1, rowOffset);
			result = stmt.executeQuery();
			
			while(result.next())
			{
				Questions.add(new Question(result.getInt(1),result.getInt(2),result.getString(3),result.getInt(4),result.getInt(5),result.getString(6)));
			}
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(result != null)
			result.close();
		if(stmt != null)
			stmt.close();
		
		return Questions;
	}
	
	@Override
	public List<Question> getFollowingQuestionsByDate(int userid, int rowOffset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List<Question> Questions = new ArrayList<Question>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Question.GETFOLLOWINGQUESTIONSBYDATE);
			stmt.setInt(1, userid);
			stmt.setInt(2, rowOffset);
			result = stmt.executeQuery();
			
			while(result.next())
			{
				Questions.add(new Question(result.getInt(1),result.getInt(2),result.getString(3),result.getInt(4),result.getInt(5),result.getString(6)));
			}
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(result != null)
			result.close();
		if(stmt != null)
			stmt.close();
		
		return Questions;
	}
	
	
	@Override
	public List<Question> getFollowingQuestionsByRank(int userid, int rowOffset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List<Question> Questions = new ArrayList<Question>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Question.GETFOLLOWINGQUESTIONSBYRANK);
			stmt.setInt(1, userid);
			stmt.setInt(2, rowOffset);
			result = stmt.executeQuery();
			
			while(result.next())
			{
				Questions.add(new Question(result.getInt(1),result.getInt(2),result.getString(3),result.getInt(4),result.getInt(5),result.getString(6)));
			}
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(result != null)
			result.close();
		if(stmt != null)
			stmt.close();
		
		return Questions;
	}
	

	@Override
	public Question getQuestionById(int question_id) throws SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		Question question = null;
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Question.GETQUESTIONBYID);
			stmt.setInt(1, question_id);
			result = stmt.executeQuery();
			
			if(result.next())
			{
				question = new Question(result.getInt(1),result.getInt(2),result.getString(3),result.getInt(4),result.getInt(5),result.getString(6));
			}
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(result != null)
			result.close();
		if(stmt != null)
			stmt.close();
		
		
		return question;
	}


	
	@Override
	public int createNewQuestion(int userid, String questiontext) throws SQLException {

		
		Connection conn = null;
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		ResultSet result = null;
		Integer id = null;
		String col[] = {"question_id"};
		try {
			
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Question.CREATEQUESTION, col);
			stmt.setInt(1, userid);
			stmt.setString(2, questiontext);
			stmt.executeUpdate();
			result = stmt.getGeneratedKeys();
			
			if(result.next())
			
			
			{
				id = result.getInt(1);
				stmt2 = conn.prepareStatement(OracleQueries.Question.INCUSERCREATED);
				stmt2.setInt(1, userid);
				stmt2.executeUpdate();
			}
			

			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(result != null)
			result.close();
		if(stmt != null)
			stmt.close();
		
		return id;
	}
	
	@Override
	public int getPendingCount() throws SQLException {

		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		int pendingcount = 0;

		try {
			
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Question.GETPENDINGCOUNT);
			result = stmt.executeQuery();
			
			if(result.next())
				pendingcount = result.getInt(1);
				
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(result != null)
			result.close();
		if(stmt != null)
			stmt.close();
		
		return pendingcount;
	}
	
	@Override
	public boolean deleteQuestion(int questionid) throws SQLException {

		
		Connection conn = null;
		PreparedStatement stmt = null;
		int deleted = 0;
		try {
			
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Question.DELETEQUESTION);
			stmt.setInt(1, questionid);
			deleted = stmt.executeUpdate();
			

			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(stmt != null)
			stmt.close();
		
		 return deleted>0;
	}
	
}
