package qofd.SystemInterfaces;

import java.sql.SQLException;

import qofd.Models.User;

public interface UserDAOI {

	public int registerUser (User user) throws SQLException;
	public User loginUser(String email,String password) throws SQLException;
	public User getUser(int userid);
	
	
}
