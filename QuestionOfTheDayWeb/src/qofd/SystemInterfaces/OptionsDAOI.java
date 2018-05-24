package qofd.SystemInterfaces;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import qofd.Models.Option;

public interface OptionsDAOI {

	public List<Option> getQuestionOption(int questionid) throws SQLException;
	public HashMap<Integer,List<Option>> getTopOption() throws SQLException;
	
}
