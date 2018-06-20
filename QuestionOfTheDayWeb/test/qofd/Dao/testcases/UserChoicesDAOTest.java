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

import qofd.Dao.UserChoicesDAO;

public class UserChoicesDAOTest {
	
	
	@Test
	public void userChoiceTest() throws SQLException {
		UserChoicesDAO ucDAO = new UserChoicesDAO();
		
		int chosen = ucDAO.createUserChoice(1, 80, 240);
		
		HashMap<Integer,Integer> userChoices = ucDAO.getUserChoice(1);
		System.out.println(userChoices.get(80));
		assertThat(userChoices.get(80), is(equalTo(240)));
		ucDAO.changeUserChoice(1, 80, 240, 239);
		
		userChoices = ucDAO.getUserChoice(1);
		System.out.println(userChoices.get(80));
		assertThat(userChoices.get(80), is(equalTo(239)));
		assertThat(ucDAO.deleteUserChoice(1, 80, 239), is(equalTo(true)));
	
	}

}
