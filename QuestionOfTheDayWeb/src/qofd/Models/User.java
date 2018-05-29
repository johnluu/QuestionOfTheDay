package qofd.Models;

public class User {

	private int user_id;
	private String email;
	private String password;
	private String first_name;
	private String last_name;
	private int watches;
	private int choices;
	private int comments;
	
	public User(int user_id, String email, String password, String first_name, String last_name,int watches,int choices,int comments) {
		this.user_id = user_id;
		this.email = email;
		this.password = password;
		this.first_name = first_name;
		this.last_name = last_name;
		this.watches = watches;
		this.choices = choices;
		this.comments = comments;
	}
	
	public User() {}

	public User( String email, String password, String first_name, String last_name) {
		this.email = email;
		this.password = password;
		this.first_name = first_name;
		this.last_name = last_name;
	}
	

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	};
	
}
