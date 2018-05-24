package qofd.SystemInterfaces;

import java.util.List;

import qofd.Models.New_Option;

public interface NewOptionsDAOI {

	public List<New_Option> getNewQuestionOption(int questionid);
	public boolean createNewOption(int questionid,String option_text);
	
	
}
