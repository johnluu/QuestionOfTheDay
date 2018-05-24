package qofd.Models;

public class Question {

	private int question_id;
	private int user_id;
	private String question_text;
	private int question_score;
	private int watches;
	private String date;
	
	public Question(int question_id, int user_id, String question_text, int question_score, int watches, String date) {
		this.question_id = question_id;
		this.user_id = user_id;
		this.question_text = question_text;
		this.question_score = question_score;
		this.watches = watches;
		this.date = date;
	}
	
	public Question() {}

	public int getQuestion_id() {
		return question_id;
	}

	public void setQuestion_id(int question_id) {
		this.question_id = question_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getQuestion_text() {
		return question_text;
	}

	public void setQuestion_text(String question_text) {
		this.question_text = question_text;
	}

	public int getQuestion_score() {
		return question_score;
	}

	public void setQuestion_score(int question_score) {
		this.question_score = question_score;
	}

	public int getWatches() {
		return watches;
	}

	public void setWatches(int watches) {
		this.watches = watches;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	};
	
	
}
