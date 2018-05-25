package qofd.SystemInterfaces;

import java.sql.SQLException;
import java.util.List;

import qofd.Models.Comments;

public interface CommentDAOI {

	public List<Comments> getQuestionComments(int questionid) throws SQLException;
	public int createComment(Comments comment) throws SQLException;
	
}
