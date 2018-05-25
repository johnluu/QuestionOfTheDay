package qofd.Models;

public class Comments {

	private int comment_id;
	private int user_id;
	private int question_id;
	private int option_id;
	private String comment_text;
	private int comment_score;
	private String comment_date;
	
	
	public Comments(int comment_id, int user_id, int question_id, int option_id, String comment_text, int comment_score,
			String comment_date) {
		this.comment_id = comment_id;
		this.user_id = user_id;
		this.question_id = question_id;
		this.option_id = option_id;
		this.comment_text = comment_text;
		this.comment_score = comment_score;
		this.comment_date = comment_date;
	}
	
	
	public Comments( int user_id, int question_id, int option_id, String comment_text) {
		this.user_id = user_id;
		this.question_id = question_id;
		this.option_id = option_id;
		this.comment_text = comment_text;
	}

	public Comments() {}

	public int getComment_id() {
		return comment_id;
	}


	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}


	public int getUser_id() {
		return user_id;
	}


	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}


	public int getQuestion_id() {
		return question_id;
	}


	public void setQuestion_id(int question_id) {
		this.question_id = question_id;
	}


	public int getOption_id() {
		return option_id;
	}


	public void setOption_id(int option_id) {
		this.option_id = option_id;
	}


	public String getComment_text() {
		return comment_text;
	}


	public void setComment_text(String comment_text) {
		this.comment_text = comment_text;
	}


	public int getComment_score() {
		return comment_score;
	}


	public void setComment_score(int comment_score) {
		this.comment_score = comment_score;
	}


	public String getComment_date() {
		return comment_date;
	}


	public void setComment_date(String comment_date) {
		this.comment_date = comment_date;
	}
	
	
}
