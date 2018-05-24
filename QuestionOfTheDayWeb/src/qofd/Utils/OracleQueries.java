package qofd.Utils;

public class OracleQueries {
	public final static String REGISTERUSER= "INSERT INTO USERS(EMAIL,PASSWORD,FIRST_NAME,LAST_NAME) "
			+ "VALUES(?,?,?,?)";
	
	public final static String GETUSER = "SELECT * FROM USERS "
			+ "WHERE USER_ID = ?";
	
	public final static String GETUSERBYEMAIL= "SELECT * FROM USERS "
			+ "WHERE EMAIL = ?";
	
	public final static String CREATEQUESTION = "insert into new_questions (user_id,question_text,question_date) "
			+ "values(?,?,sysdate)";
		
	public final static String CREATEOPTION = "insert into new_options(question_id,option_text) "
			+ "values(?,?)";
	
	public final static String GETTOPNEWQUESTION = "SELECT * FROM NEW_QUESTIONS "
			+ "order by watches desc, question_date asc "
			+ "fetch first 5 rows only";
	
	public final static String GETALLNEWQUESTIONS = "SELECT * FROM NEW_QUESTIONS "
			+ "order by watches desc, question_date desc ";
			
	public final static String GETNEWQUESTION = "SELECT * FROM NEW_QUESTIONS "
			+ "where Question_id = ? ";

	public final static String GETNEWQUESTIONOPTION = "SELECT * FROM NEW_OPTIONS "
			+ "where Question_id = ? ";
	
	public final static String ISWATCHING = "SELECT Question_Id FROM USER_WATCHING "
			+ "where USER_id = ?";
	
	public final static String WATCHQUESTION = "INSERT INTO USER_WATCHING (USER_ID, QUESTION_ID) " +
			"VALUES (?,?)"; 
	
	public final static String  UNWATCHQUESTION = "DELETE USER_WATCHING "
			+ "where USER_ID = ? AND QUESTION_ID = ?";
	
	public final static String INCWATCH = "UPDATE NEW_QUESTIONS SET WATCHES = WATCHES + 1 "
			+ "where question_id = ?";
	
	public final static String DECWATCH = "UPDATE NEW_QUESTIONS SET WATCHES = WATCHES - 1 "
			+ "where question_id = ?";
	
	public final static String  GETALLQUESTION = "SELECT * FROM QUESTIONS";

	public final static String  GETTODAYQUESTION = "SELECT * FROM QUESTIONS "
			+ "where QUESTION_DATE >= trunc(sysdate)";
	
	public final static String  GETQUESTION = "SELECT * FROM QUESTIONS "
			+ "where QUESTION_ID = ? ";
	
	public final static String  GETUSERCHOICES = "SELECT QUESTION_ID,OPTION_ID FROM USER_CHOICES "
			+ "where USER_ID = ? ";
	
	public final static String  CREATEUSERCHOICES = "INSERT INTO USER_CHOICES(USER_ID,QUESTION_ID,OPTION_ID) "
			+ "VALUES(?,?,?)";
	
	public final static String INCOPTIONSCORE = "UPDATE OPTIONS SET OPTION_SCORE = OPTION_SCORE + 1 " + 
			"WHERE OPTION_ID = ?";
	
	public final static String DECOPTIONSCORE = "UPDATE OPTIONS SET OPTION_SCORE = OPTION_SCORE - 1 " + 
			"WHERE OPTION_ID = ?";
	
	public final static String  UPDATEUSERCHOICES = "UPDATE USER_CHOICES SET OPTION_ID = ? "
			+ "WHERE USER_ID = ? AND QUESTION_ID = ? ";
			
	public final static String  GETTOPOPTIONS = "SELECT OPTIONS.* FROM OPTIONS "
	+ "JOIN QUESTIONS ON QUESTIONS.QUESTION_ID = OPTIONS.QUESTION_ID "
		+		 "where QUESTIONS.QUESTION_DATE >= trunc(sysdate)";
}
