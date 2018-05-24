package qofd.Dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import qofd.Models.New_Question;
import qofd.SystemInterfaces.NewQuestionDAOI;
import qofd.Utils.OracleQueries;

public class NewQuestionDAO implements NewQuestionDAOI{

	@Override
	public New_Question getnewQuestion(int questionid) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		New_Question newquestion = null;
		
		 try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.GETNEWQUESTION);
			stmt.setInt(1, questionid);
			result = stmt.executeQuery();
			
			if(result.next())
				newquestion = new New_Question(result.getInt(1),result.getInt(2),result.getString(3),result.getInt(4),result.getString(5));
			
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			e.printStackTrace();
		}
		 
			if(conn != null)
				conn.close();
			if(result != null)
				result.close();
			if(stmt != null)
				stmt.close();
		
		return newquestion;
	}
	
	@Override
	public List<New_Question> getAllNewQuestion() {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List<New_Question> NewQuestions = new ArrayList<New_Question>();
		
		 try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.GETALLNEWQUESTIONS);
			result = stmt.executeQuery();
			
			while(result.next())
				NewQuestions.add(new New_Question(result.getInt(1),result.getInt(2),result.getString(3),result.getInt(4),result.getString(5)));
			
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return NewQuestions;
	}

	@Override
	public List<New_Question> getTopNewQuestion() throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List<New_Question> TopNewQuestion = new ArrayList<New_Question>();
		
		 try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.GETTOPNEWQUESTION);
			result = stmt.executeQuery();
			
			while(result.next())
				TopNewQuestion.add(new New_Question(result.getInt(1),result.getInt(2),result.getString(3),result.getInt(4),result.getString(5)));
			
			
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
		 
		return TopNewQuestion;
	}

	@Override
	public boolean createNewQuestion(int userid, String questiontext,String[] options) throws SQLException {

		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		Integer id = null;
		String col[] = {"question_id"};
		
		try {
			System.out.println("HEHEHEHEGHE");
			
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.CREATEQUESTION, col);
			stmt.setInt(1, userid);
			stmt.setString(2, questiontext);
			stmt.executeUpdate();
			result = stmt.getGeneratedKeys();
			if(result.next())
			{
				id = result.getInt(1);
				System.out.println(id);
			}
			NewOptionsDAO opDAO = new NewOptionsDAO();
			
			for(String s: options)
			{	System.out.println("inserting into " + id);
				opDAO.createNewOption(id, s);
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
