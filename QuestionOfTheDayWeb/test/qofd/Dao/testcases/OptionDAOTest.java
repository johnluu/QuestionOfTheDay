package qofd.Dao.testcases;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.Test;

import qofd.Dao.OptionDAO;
import qofd.Models.Option;
import qofd.Models.Question;


public class OptionDAOTest {

	@Test
	public void createOptionTest() throws SQLException {

		OptionDAO oDAO = new OptionDAO();
		
		int optionid = oDAO.createOption(80, "Hello World");
		Option o = oDAO.getOptionById(optionid);
		
		System.out.println(o.get_question_id() + " " + o.getOption_text());
		
		assertThat(o.get_question_id(), is(equalTo(80)));
		assertThat(o.getOption_text(), is(equalTo("Hello World")));
		
		assertThat(oDAO.deleteOption(optionid),is(equalTo(true)));	
	
	}
	
	@Test
	public void optionQueryTest() throws SQLException{
		
		OptionDAO oDAO = new OptionDAO();

		HashMap<Integer,List<Option>> optionListByDate = oDAO.getOptionByDate(1);
		optionListByDate.forEach((k,v) -> {
			for(Option o: v)
			{
			assertThat(o.get_question_id(), is(equalTo(k)));
			}
		});
		
		
		HashMap<Integer,List<Option>> optionlistByRank = oDAO.getOptionsByRank(1);
		optionlistByRank.forEach((k,v) -> {
			for(Option o: v)
			{
			assertThat(o.get_question_id(), is(equalTo(k)));
			}
		});

		HashMap<Integer,List<Option>> archivedOptionListByDate = oDAO.getArchiveOptionsByRank(8);
		archivedOptionListByDate.forEach((k,v) -> {
			for(Option o: v)
			{
			assertThat(o.get_question_id(), is(equalTo(k)));
			}
		});
		
		HashMap<Integer,List<Option>> archivedoptionlistByRank = oDAO.getArchiveOptionsByRank(1);
		archivedoptionlistByRank.forEach((k,v) -> {
			for(Option o: v)
			{
			assertThat(o.get_question_id(), is(equalTo(k)));
			}
		});
		
		

			List<Option> questionOption = oDAO.getOptionsByQuestionId(80);
			assertThat(questionOption.get(0).get_question_id(), is(equalTo(80)));
			assertThat(questionOption.get(0).getOptions_id(), is(equalTo(238)));
			
			assertThat(questionOption.get(1).get_question_id(), is(equalTo(80)));
			assertThat(questionOption.get(1).getOptions_id(), is(equalTo(239)));
			
			assertThat(questionOption.get(2).get_question_id(), is(equalTo(80)));
			assertThat(questionOption.get(2).getOptions_id(), is(equalTo(240)));


		
	}
	
}
