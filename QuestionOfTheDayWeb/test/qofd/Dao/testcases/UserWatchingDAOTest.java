package qofd.Dao.testcases;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

import java.sql.SQLException;
import java.util.HashSet;

import org.junit.Test;

import qofd.Dao.UserWatchingDAO;

public class UserWatchingDAOTest {

	
	@Test
	public void userChoiceTest() throws SQLException {
		UserWatchingDAO uwDAO = new UserWatchingDAO();
		HashSet<Integer> userwatching = uwDAO.isWatching(71);
		uwDAO.unwatch(1, 71);
		userwatching = uwDAO.isWatching(71);
		assertThat(userwatching.contains(71), is(equalTo(false)));
		
		int watching = uwDAO.watch(1, 71);
		userwatching.contains(watching);
		
		
		userwatching = uwDAO.isWatching(1);
		assertThat(userwatching.contains(71), is(equalTo(true)));

	
	}
	
	
	
	
	
	
	
	
}
