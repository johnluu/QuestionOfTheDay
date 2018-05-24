package qofd.Dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import qofd.Models.User;
import qofd.SystemInterfaces.UserDAOI;
import qofd.Utils.OracleQueries;

public class UserDAO implements UserDAOI{

	@Override
	public int registerUser(User user) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		int id = 0;
		String[] col = {"user_id"};
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.REGISTERUSER,col);
			stmt.setString(1, user.getEmail());
			stmt.setString(2, user.getPassword());
			stmt.setString(3, user.getFirst_name());
			stmt.setString(4, user.getLast_name());
			stmt.executeUpdate();
			
			
			result = stmt.getGeneratedKeys();
			
			if(result.next())
				id = result.getInt(1);
			
		} catch (ClassNotFoundException | IOException | SQLException e) {

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
	public User loginUser(String email, String password) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		User user = null;
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.GETUSERBYEMAIL);
			stmt.setString(1, email);
			result = stmt.executeQuery();
			
			if(result.next())
				user = new User(result.getInt(1),result.getString(2),result.getString(3),result.getString(4),result.getString(5));
			
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
		
		
		
		
		if(user != null && user.getPassword().equals(password))
			return user;
		
		else
			return null;
	}


	@Override
	public User getUser(int userid) {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		User user = null;
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.GETUSER);
			stmt.setInt(1, userid);
			result = stmt.executeQuery();
			
			if(result.next())
				user = new User(result.getInt(1),result.getString(2),result.getString(3),result.getString(4),result.getString(5));
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return user;
	}

}
