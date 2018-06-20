package qofd.SystemInterfaces;

import java.sql.SQLException;
import java.util.HashMap;

import qofd.Models.User;

public interface UserDAOI {

	public int registerUser (User user) throws SQLException;
	public User loginUser(String email,String password) throws SQLException;
	public User getUser(int userid) throws SQLException;
	public int removeUser(int userid) throws SQLException;
	int[] getUserFollowing(int userid) throws SQLException;
	HashMap<Integer, User> getCommentUsers(int questionid) throws SQLException;
	HashMap<Integer, User> getCreatorListByDates(int offset) throws SQLException;
	HashMap<Integer, User> getCreatorListByRank(int offset) throws SQLException;
	HashMap<Integer, User> getCreatorListArchiveByRank(int offset) throws SQLException;
	HashMap<Integer, User> getCreatorListPendingByDate(int offset) throws SQLException;
	HashMap<Integer, User> getCreatorListPendingByRank(int offset) throws SQLException;
	HashMap<Integer, User> getCreatorListFollowByDate(int userid, int offset) throws SQLException;
	HashMap<Integer, User> getCreatorListFollowByRank(int userid, int offset) throws SQLException;
	
	
}
