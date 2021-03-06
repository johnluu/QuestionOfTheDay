package qofd.SystemInterfaces;

import java.sql.SQLException;
import java.util.HashMap;


public interface UserChoicesDAOI {

	public int createUserChoice(int userid,int questionid,int optionid) throws SQLException;
	public int changeUserChoice(int userid,int questionid, int oldoptionid, int optionid ) throws SQLException;
	public HashMap<Integer,Integer> getUserChoice(int userid) throws SQLException;
	public int getUserQChoice(int userid, int questionid) throws SQLException;
	HashMap<Integer, Integer> getUserChoiceByRank(int userid , int rowOffset) throws SQLException;
	HashMap<Integer, Integer> getUserChoiceByDate(int userid, int intDateOffset) throws SQLException;
	boolean deleteUserChoice(int userid, int questionid, int optionid) throws SQLException;
	int getFollowing(int userid) throws SQLException;
	int getArchiveFollowing(int userid) throws SQLException;

	
}
