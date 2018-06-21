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
		PreparedStatement stmt3 = null;
		int id = 0;
		ResultSet result = null;
		String[] col = {"question_id"};
		
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Watching.WATCHQUESTION, col);
			stmt2 = conn.prepareStatement(OracleQueries.Watching.INCWATCH);
			stmt3 = conn.prepareStatement(OracleQueries.Watching.INCUSERWATCH);

			stmt.setInt(1, userid);
			stmt.setInt(2, questionid);
			
			stmt.executeUpdate();
			result = stmt.getGeneratedKeys();
			
			
			if(result.next())
				{id = result.getInt(1);
				stmt2.setInt(1, questionid);
				stmt3.setInt(1, userid);
				stmt2.executeUpdate();
				stmt3.executeUpdate();
				}
			
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
		if(stmt3 != null)
			stmt3.close();
		
		return id;
	}

	
	@Override
	public boolean unwatch(int userid, int questionid) throws SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt3 = null;

		int result = 0;
		
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Watching.UNWATCHQUESTION);
			stmt2 = conn.prepareStatement(OracleQueries.Watching.DECWATCH);
			stmt3 = conn.prepareStatement(OracleQueries.Watching.DECUSERWATCH);

			
			
			stmt.setInt(1, userid);
			stmt.setInt(2, questionid);
			
			result = stmt.executeUpdate();
			
			if(result > 0)
			{	
				stmt2.setInt(1, questionid);
				stmt2.executeUpdate();
				stmt3.setInt(1, userid);
				stmt3.executeUpdate();
			}
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(stmt != null)
			stmt.close();
		if(stmt2 != null)
			stmt2.close();
		if(stmt3 != null)
			stmt3.close();
		
		return result > 0;
	}

	
	
	@Override
	public HashSet<Integer> isWatching(int userid) throws SQLException {
			
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashSet<Integer> isWatching = new HashSet<Integer>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Watching.ISWATCHING);
			stmt.setInt(1, userid);
			result = stmt.executeQuery();
			
			while(result.next())
				isWatching.add(result.getInt(1));
			
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


		
			
		return isWatching;
	}
	
	@Override
	public Integer getWatchCount() throws SQLException {
			
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		Integer watchCount = 0;
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Watching.WATCHINGCOUNT);
			result = stmt.executeQuery();
			
			if(result.next())
				watchCount = result.getInt(1);
			
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
		
			
		return watchCount;
	}


}
