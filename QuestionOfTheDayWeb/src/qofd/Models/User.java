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
	private int questions_created;
	private String join_date;
	
	public User(int user_id, String email, String password, String first_name, String last_name,int watches,int choices,int comments,int questions_created, String join_date) {
		this.user_id = user_id;
		this.email = email;
		this.password = password;
		this.first_name = first_name;
		this.last_name = last_name;
		this.watches = watches;
		this.choices = choices;
		this.comments = comments;
		this.questions_created = questions_created;
		this.join_date = join_date;
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
	}

	public int getWatches() {
		return watches;
	}

	public void setWatches(int watches) {
		this.watches = watches;
	}

	public int getChoices() {
		return choices;
	}

	public void setChoices(int choices) {
		this.choices = choices;
	}

	public int getComments() {
		return comments;
	}

	public void setComments(int comments) {
		this.comments = comments;
	}

	public int getQuestions_created() {
		return questions_created;
	}

	public void setQuestions_created(int questions_created) {
		this.questions_created = questions_created;
	}

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	};
	
	
}
