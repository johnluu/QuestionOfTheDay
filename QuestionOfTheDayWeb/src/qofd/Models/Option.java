package qofd.Models;

public class Option {

	private int options_id;
	private int question_id;
	private String option_text;
	private int Option_score;
	
	public Option(int options_id, int new_question_id, String option_text, int option_score) {
		this.options_id = options_id;
		this.question_id = new_question_id;
		this.option_text = option_text;
		Option_score = option_score;
	}
	
	public Option() {}

	public int getOptions_id() {
		return options_id;
	}

	public void setOptions_id(int options_id) {
		this.options_id = options_id;
	}

	public int get_question_id() {
		return question_id;
	}

	public void setNew_question_id(int question_id) {
		this.question_id = question_id;
	}

	public String getOption_text() {
		return option_text;
	}

	public void setOption_text(String option_text) {
		this.option_text = option_text;
	}

	public int getOption_score() {
		return Option_score;
	}

	public void setOption_score(int option_score) {
		Option_score = option_score;
	}
	
	
}
