package qofd.Dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import qofd.Models.Comments;
import qofd.SystemInterfaces.CommentDAOI;
import qofd.Utils.OracleQueries;

public class CommentDAO implements CommentDAOI {

	@Override
	public List<Comments> getQuestionComments(int questionid) throws SQLException {

			
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet result = null;
			List<Comments> questionComments = new ArrayList<Comments>();
			
			try {
				conn = OracleConnection.getConnection();
				stmt = conn.prepareStatement(OracleQueries.GETQUESTIONCOMMENT);
				stmt.setInt(1, questionid);
				result = stmt.executeQuery();
				
				while(result.next())
					questionComments.add(new Comments(result.getInt(1),result.getInt(2),result.getInt(3),
							result.getInt(4),result.getString(5),result.getInt(6),result.getString(7)));
					
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
			

			
		
		return questionComments;
	}

	@Override
	public int createComment(Comments comment) throws SQLException {
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		int id = 0;
		String[] col = {"comment_id"};
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.CREATECOMMENT,col);
			stmt.setInt(1, comment.getUser_id());
			stmt.setInt(2, comment.getQuestion_id());
			stmt.setInt(3, comment.getOption_id());
			stmt.setString(4, comment.getComment_text());
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

}
