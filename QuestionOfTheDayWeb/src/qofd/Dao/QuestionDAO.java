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
	public List<Question> getAllQuestion() throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List<Question> Questions = new ArrayList<Question>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.GETALLQUESTION);
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
	public List<Question> getTodaysQuestion() throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List<Question> Questions = new ArrayList<Question>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.GETTODAYQUESTION);
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
	public Question getQuestion(int question_id) throws SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		Question question = null;
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.GETQUESTION);
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

}
