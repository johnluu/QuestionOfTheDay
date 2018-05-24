package qofd.Dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;

import qofd.SystemInterfaces.UserWatchingDAOI;
import qofd.Utils.OracleQueries;

public class UserWatchingDAO implements UserWatchingDAOI {

	@Override
	public int watch(int userid, int questionid) throws SQLException {
		
		Connection conn = null;
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		int id = 0;
		ResultSet result = null;
		String[] col = {"question_id"};
		
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.WATCHQUESTION, col);
			stmt2 = conn.prepareStatement(OracleQueries.INCWATCH);
			
			stmt.setInt(1, userid);
			stmt.setInt(2, questionid);
			stmt2.setInt(1, questionid);
			
			stmt.executeUpdate();
			result = stmt.getGeneratedKeys();
			stmt2.executeUpdate();
			
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
		if(stmt2 != null)
			stmt2.close();
		
		System.out.println(id);
		return id;
	}

	
	@Override
	public int unwatch(int userid, int questionid) {
		Connection conn = null;
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		int id = 0;
		ResultSet result = null;
		String[] col = {"question_id"};
		
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.UNWATCHQUESTION, col);
			stmt2 = conn.prepareStatement(OracleQueries.DECWATCH);
			
			stmt.setInt(1, userid);
			stmt.setInt(2, questionid);
			stmt2.setInt(1, questionid);
			
			stmt.executeUpdate();
			result = stmt.getGeneratedKeys();
			stmt2.executeUpdate();
			
			if(result.next())
				id = result.getInt(1);
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			e.printStackTrace();
		}
		
		return id;
	}

	
	
	@Override
	public HashSet<Integer> isWatching(int userid) {
			
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashSet<Integer> isWatching = new HashSet<Integer>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.ISWATCHING);
			stmt.setInt(1, userid);
			result = stmt.executeQuery();
			
			while(result.next())
				isWatching.add(result.getInt(1));
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
			
		return isWatching;
	}


}
