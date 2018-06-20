package qofd.Dao.testcases;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

import java.sql.SQLException;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.Test;

import qofd.Dao.UserDAO;
import qofd.Models.User;

public class UserDAOTest {

	String email;
	String password;
	String first_name;
	String last_name;

	@Before
	public void userTestCase(){
		
		email = "email";
		password = "password";
		first_name = "first_name";
		last_name = "last_name";
	}
	
	@Test
	public void testUser() throws SQLException {
		UserDAO uDAO = new UserDAO();
		int userid = uDAO.registerUser(new User(email, password,first_name, last_name));
		
		User user = uDAO.getUser(userid);
		
		assertThat(user.getPassword(), is(equalTo(password)));
		assertThat(user.getEmail(), is(equalTo(email)));
		assertThat(user.getFirst_name(), is(equalTo(first_name)));
		assertThat(user.getLast_name(), is(equalTo(last_name)));
		
		User loggeduser = uDAO.loginUser(email, password);
		
		assertThat(loggeduser.getPassword(), is(equalTo(password)));
		assertThat(loggeduser.getEmail(), is(equalTo(email)));
		assertThat(loggeduser.getFirst_name(), is(equalTo(first_name)));
		assertThat(loggeduser.getLast_name(), is(equalTo(last_name)));
		
		uDAO.removeUser(user.getUser_id());

	}
	
	
}

