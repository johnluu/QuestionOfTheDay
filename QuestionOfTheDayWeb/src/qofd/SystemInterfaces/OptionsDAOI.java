package qofd.SystemInterfaces;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import qofd.Models.Option;

public interface OptionsDAOI {

	public HashMap<Integer, List<Option>> getOptionByDate(int dateOffset) throws SQLException;
	public HashMap<Integer, List<Option>> getOptionsByRank(int rowOffset) throws SQLException;
	int createOption(int questionid, String option_text);
	List<Option> getOptionsByQuestionId(int questionid) throws SQLException;
	HashMap<Integer, List<Option>> getOptionArchiveByDate(int dateOffset) throws SQLException;
	HashMap<Integer, List<Option>> getArchiveOptionsByRank(int rowOffset) throws SQLException;
	Option getOptionById(int optionid) throws SQLException;
	boolean deleteOption(int optionid) throws SQLException;
	HashMap<Integer, List<Option>> getFollowingOptionByDate(int userid, int offset) throws SQLException;
	HashMap<Integer, List<Option>> getFollowingOptionByRank(int userid, int offset) throws SQLException;
	HashMap<Integer, List<Option>> getPendingOptionsByDate(int rowOffset) throws SQLException;
	HashMap<Integer, List<Option>> getPendingOptionsByRank(int rowOffset) throws SQLException;
	
}
