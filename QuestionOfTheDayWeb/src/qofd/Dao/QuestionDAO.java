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
	public List<Question> getQuestionArchiveByDate(int dateOffset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List<Question> Questions = new ArrayList<Question>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Question.GETQUESTIONARCHIVEBYDATE);
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
	public boolean createNewQuestion(int userid, String questiontext,String[] options) throws SQLException {

		
		Connection conn = null;
		PreparedStatement stmt = null;
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
				System.out.println(id);
			}
			OptionDAO opDAO = new OptionDAO();
			
			for(String s: options)
			{	System.out.println("inserting into " + id);
				opDAO.createOption(id, s);
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
		
		return false;
	}
	
}
