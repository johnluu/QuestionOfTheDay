package qofd.SystemInterfaces;

import java.sql.SQLException;
import java.util.HashMap;

import qofd.Models.Option;

public interface UserChoicesDAOI {

	public int createUserChoice(int userid,int questionid,int optionid) throws SQLException;
	public int changeUserChoice(int userid,int questionid, int oldoptionid, int optionid ) throws SQLException;
	public HashMap<Integer,Integer> getUserChoice(int userid) throws SQLException;
	
	
}
