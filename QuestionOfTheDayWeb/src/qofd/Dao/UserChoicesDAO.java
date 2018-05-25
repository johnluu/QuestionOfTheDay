package qofd.Dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import qofd.SystemInterfaces.UserChoicesDAOI;
import qofd.Utils.OracleQueries;

public class UserChoicesDAO implements UserChoicesDAOI{

	@Override
	public int createUserChoice(int userid, int questionid, int optionid) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt3 = null;
		int id = 0;
		ResultSet result = null;
		String[] col = {"option_id"};
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.CREATEUSERCHOICES, col);

			
			stmt.setInt(1, userid);
			stmt.setInt(2, questionid);
			stmt.setInt(3, optionid);
			

			
			stmt.executeUpdate();
			result = stmt.getGeneratedKeys();
			
			if (result.next())
			{
				
				stmt3 = conn.prepareStatement(OracleQueries.INCQUESTIONSCORE);
				stmt3.setInt(1,questionid);
				stmt3.executeUpdate();
				
				stmt2 = conn.prepareStatement(OracleQueries.INCOPTIONSCORE);
				stmt2.setInt(1, optionid);
				stmt2.executeUpdate();
				
				id = result.getInt(1);
			
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
		if(stmt2 != null)
			stmt.close();
		if(stmt3 != null)
			stmt3.close();
		
		
		
		return id;
	}

	@Override
	public int changeUserChoice(int userid, int questionid,int oldoptionid, int optionid ) throws SQLException {
		

		Connection conn = null;
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt3 = null;
		int result = 0;
		String[] col = {"OPTION_ID"};
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.UPDATEUSERCHOICES, col);
			
			stmt.setInt(1, optionid);
			stmt.setInt(2, userid);
			stmt.setInt(3, questionid);
			

			
				result = stmt.executeUpdate();
				
				if(result > 0) {
				stmt2 = conn.prepareStatement(OracleQueries.DECOPTIONSCORE);
				stmt3 = conn.prepareStatement(OracleQueries.INCOPTIONSCORE);
				
				
				stmt2.setInt(1, oldoptionid);
				stmt2.executeUpdate();
				stmt3.setInt(1, optionid);
				stmt3.executeUpdate();
				}
			
			
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		if(conn != null)
			conn.close();
		if(stmt != null)
			stmt.close();
		if(stmt2 != null)
			stmt.close();
		if(stmt3 != null)
			stmt3.close();
		
		return result;
	}

	@Override
	public HashMap<Integer, Integer> getUserChoice(int userid) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement stmt = null;
		HashMap<Integer,Integer>userChoices = new HashMap<Integer,Integer>();
		ResultSet result = null;
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.GETUSERCHOICES);
			stmt.setInt(1, userid);
			result = stmt.executeQuery();
			
			while (result.next())
				userChoices.put(result.getInt(1), result.getInt(2));
			
			
			
			
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
		
		
		return userChoices;
	}
	
	@Override
	public int getUserQChoice(int userid, int questionid) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement stmt = null;
		int userChoice = 0;
		ResultSet result = null;
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.GETUSERQCHOICES);
			stmt.setInt(1, userid);
			stmt.setInt(2, questionid);
			result = stmt.executeQuery();
			
			if (result.next())
				userChoice = result.getInt(1);
			
			
			
			
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
		
		
		return userChoice;
	}

}
