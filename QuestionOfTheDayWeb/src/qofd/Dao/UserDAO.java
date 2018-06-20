package qofd.Dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

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
			stmt = conn.prepareStatement(OracleQueries.User.REGISTERUSER,col);
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
			stmt = conn.prepareStatement(OracleQueries.User.GETUSERBYEMAIL);
			stmt.setString(1, email);
			result = stmt.executeQuery();
			
			if(result.next())
				user = new User(result.getInt(1),result.getString(2),result.getString(3),result.getString(4),result.getString(5),result.getInt(6),
						result.getInt(7),result.getInt(8),result.getInt(9),result.getString(10));
			
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
	public User getUser(int userid) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		User user = null;
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.User.GETUSER);
			stmt.setInt(1, userid);
			result = stmt.executeQuery();
			
			if(result.next())
				user = new User(result.getInt(1),result.getString(2),result.getString(3),result.getString(4),result.getString(5),
						result.getInt(6),result.getInt(7),result.getInt(8),result.getInt(9),result.getString(10));
			
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
		
		
		return user;
	}

	@Override
	public int removeUser(int userid) throws SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		int id = 0;
		String[] col = {"user_id"};
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.User.DELETEUSER,col);
			stmt.setInt(1, userid);
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
	public int[] getUserFollowing(int userid) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		int array[] = new int[3];
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.User.GETUSERFOLLOWING);
			stmt.setInt(1, userid);
			stmt.setInt(2, userid);
			stmt.setInt(3, userid);
			result = stmt.executeQuery();
			
			if(result.next()) {
				array[0] = result.getInt(1);
				array[1] = result.getInt(2);
				array[2] = result.getInt(3);
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
		
		
		return array;
	}
	
	
	@Override
	public HashMap<Integer,User> getCommentUsers(int questionid) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer,User> userList = new HashMap<Integer,User>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.User.GETCOMMENTUSERS);
			stmt.setInt(1, questionid);

			result = stmt.executeQuery();
			
			while(result.next()) {
				User user = new User(result.getInt(1),result.getString(2),result.getString(3),result.getString(4),result.getString(5),result.getInt(6),
						result.getInt(7),result.getInt(8),result.getInt(9),result.getString(10));
				userList.put(user.getUser_id(), user);
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
		
		
		return userList;
	}
	
	@Override
	public HashMap<Integer,User> getCreatorListByDates(int offset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer,User> userList = new HashMap<Integer,User>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.User.GETCREATORLISTBYDATE);
			stmt.setInt(1, offset);
			stmt.setInt(2, offset);

			result = stmt.executeQuery();
			
			while(result.next()) {
				User user = new User(result.getInt(1),result.getString(2),result.getString(3),result.getString(4),result.getString(5),result.getInt(6),
						result.getInt(7),result.getInt(8),result.getInt(9),result.getString(10));
				userList.put(user.getUser_id(), user);
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
		
		
		return userList;
	}
	
	@Override
	public HashMap<Integer,User> getCreatorListByRank(int offset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer,User> userList = new HashMap<Integer,User>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.User.GETCREATORLISTBYRANK);
			stmt.setInt(1, offset);

			result = stmt.executeQuery();
			
			while(result.next()) {
				User user = new User(result.getInt(1),result.getString(2),result.getString(3),result.getString(4),result.getString(5),result.getInt(6),
						result.getInt(7),result.getInt(8),result.getInt(9),result.getString(10));
				userList.put(user.getUser_id(), user);
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
		
		
		return userList;
	}

	@Override
	public HashMap<Integer,User> getCreatorListArchiveByRank(int offset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer,User> userList = new HashMap<Integer,User>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.User.GETCREATORLISTARCHIVEBYRANK);
			stmt.setInt(1, offset);

			result = stmt.executeQuery();
			
			while(result.next()) {
				User user = new User(result.getInt(1),result.getString(2),result.getString(3),result.getString(4),result.getString(5),result.getInt(6),
						result.getInt(7),result.getInt(8),result.getInt(9),result.getString(10));
				userList.put(user.getUser_id(), user);
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
		
		
		return userList;
	}

	@Override
	public HashMap<Integer,User> getCreatorListPendingByDate(int offset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer,User> userList = new HashMap<Integer,User>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.User.GETCREATORLISTPENDINGBYDATE);
			stmt.setInt(1, offset);

			result = stmt.executeQuery();
			
			while(result.next()) {
				User user = new User(result.getInt(1),result.getString(2),result.getString(3),result.getString(4),result.getString(5),result.getInt(6),
						result.getInt(7),result.getInt(8),result.getInt(9),result.getString(10));
				userList.put(user.getUser_id(), user);
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
		
		
		return userList;
	}
	
	@Override
	public HashMap<Integer,User> getCreatorListPendingByRank(int offset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer,User> userList = new HashMap<Integer,User>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.User.GETCREATORLISTPENDINGBYRANK);
			stmt.setInt(1, offset);

			result = stmt.executeQuery();
			
			while(result.next()) {
				User user = new User(result.getInt(1),result.getString(2),result.getString(3),result.getString(4),result.getString(5),result.getInt(6),
						result.getInt(7),result.getInt(8),result.getInt(9),result.getString(10));
				userList.put(user.getUser_id(), user);
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
		
		
		return userList;
	}
	
	@Override
	public HashMap<Integer,User> getCreatorListFollowByDate(int userid, int offset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer,User> userList = new HashMap<Integer,User>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.User.GETCREATORLISTFOLLOWINGBYYDATE);
			stmt.setInt(1, userid);
			stmt.setInt(2, offset);

			result = stmt.executeQuery();
			
			while(result.next()) {
				User user = new User(result.getInt(1),result.getString(2),result.getString(3),result.getString(4),result.getString(5),result.getInt(6),
						result.getInt(7),result.getInt(8),result.getInt(9),result.getString(10));
				userList.put(user.getUser_id(), user);
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
		
		
		return userList;
	}
	
	@Override
	public HashMap<Integer,User> getCreatorListFollowByRank(int userid, int offset) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer,User> userList = new HashMap<Integer,User>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.User.GETCREATORLISTFOLLOWINGBYYRANK);
			stmt.setInt(1, userid);
			stmt.setInt(2, offset);

			result = stmt.executeQuery();
			
			while(result.next()) {
				User user = new User(result.getInt(1),result.getString(2),result.getString(3),result.getString(4),result.getString(5),result.getInt(6),
						result.getInt(7),result.getInt(8),result.getInt(9),result.getString(10));
				userList.put(user.getUser_id(), user);
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
		
		
		return userList;
	}
	
	
}

