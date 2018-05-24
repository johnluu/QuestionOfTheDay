package qofd.SystemInterfaces;

import qofd.Models.Option;

public interface UserChoiceDAOI {

	public boolean createUserChoice(int userid,int questionid,int optionid);
	public boolean changeUserChoice(int userid,int questionid,int optionid);
	public Option getUserChoice(int userid,int questionid);
	
	
}
