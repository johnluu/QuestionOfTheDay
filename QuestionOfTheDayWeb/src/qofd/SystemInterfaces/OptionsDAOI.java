package qofd.SystemInterfaces;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import qofd.Models.Option;

public interface OptionsDAOI {

	public HashMap<Integer,List<Option>> getOptionByDate(int dateOffset) throws SQLException;
	public HashMap<Integer,List<Option>> getOptionsByRank(int rowOffset) throws SQLException;
	boolean createOption(int questionid, String option_text);
	List<Option> getOptionsByQuestionId(int questionid) throws SQLException;
	HashMap<Integer, List<Option>> getOptionArchiveByDate(int dateOffset) throws SQLException;
	
}
