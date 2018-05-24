package qofd.Models;

public class New_Option {

	private int options_id;
	private int new_question_id;
	private String option_text;
	
	public New_Option(int options_id, int new_question_id, String option_text) {
		this.options_id = options_id;
		this.new_question_id = new_question_id;
		this.option_text = option_text;
	}
	
	public New_Option() {}

	public int getOptions_id() {
		return options_id;
	}

	public void setOptions_id(int options_id) {
		this.options_id = options_id;
	}

	public int getNew_question_id() {
		return new_question_id;
	}

	public void setNew_question_id(int new_question_id) {
		this.new_question_id = new_question_id;
	}

	public String getOption_text() {
		return option_text;
	}

	public void setOption_text(String option_text) {
		this.option_text = option_text;
	};
	
	
}
