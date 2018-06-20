package qofd.Utils;


public class OracleQueries {
	
	public static class User{
		
	
	public final static String REGISTERUSER= "INSERT INTO USERS(EMAIL,PASSWORD,FIRST_NAME,LAST_NAME,JOIN_DATE) "
			+ "VALUES(?,?,?,?,sysdate)";
	public final static String GETUSER = "SELECT * FROM USERS "
			+ "WHERE USER_ID = ?";
	public final static String DELETEUSER = "DELETE FROM USERS "
			+ "WHERE USER_ID = ?";
	public final static String GETUSERBYEMAIL= "SELECT * FROM USERS "
			+ "WHERE EMAIL = ?";
	public final static String GETUSERFOLLOWING = "SELECT "
			+ "(SELECT COUNT(*) FROM questions where user_id = ?)AS created_question, "
			+ "(SELECT COUNT(*) FROM user_choices  where user_id = ?  ) AS user_following, "
			+ "(SELECT COUNT(*) FROM user_watching where user_id = ? ) AS user_watching "
			+ "FROM dual";
	
	public final static String GETCOMMENTUSERS = " Select distinct users.* from users "
			+ " join comments on users.user_id = comments.user_id "
			+ " where comments.QUESTION_ID = ? ";
	
	public final static String GETCREATORLISTBYDATE = " select distinct users.*  from users join questions on users.user_id = questions.user_id "
			+ " where questions.question_id  in( "
			+ " select questions.question_id from questions "
			+ " where question_date >= (trunc(sysdate) - ?) and question_date < trunc(sysdate)- (?-1))";

	public final static String GETCREATORLISTBYRANK = " select distinct users.*  from users join questions on users.user_id = questions.user_id "
			+ " where questions.question_id  in( "
			+ " select questions.question_id from questions "
			+ " where QUESTION_DATE < trunc(sysdate) and QUESTION_DATE >= trunc(sysdate)-7 "
			+ " order by question_score desc, question_date asc "
			+ " offset ((?-1)*5) rows "
			+ "  fetch first 5 rows only)";
	
	public final static String GETCREATORLISTARCHIVEBYRANK = " select distinct users.*  from users join questions on users.user_id = questions.user_id "
			+ " where questions.question_id  in( "
			+ " select questions.question_id from questions "
			+ " where QUESTION_DATE < trunc(sysdate)-7 and QUESTION_DATE >= trunc(sysdate)-14 "
			+ " order by question_score desc, question_date asc "
			+ " offset ((?-1)*5) rows "
			+ "  fetch first 5 rows only)";

	
	public final static String GETCREATORLISTPENDINGBYDATE = " select distinct users.*  from users join questions on users.user_id = questions.user_id "
			+ " where questions.question_id  in( "
			+ " select questions.question_id from questions "
			+ " where QUESTION_DATE >= trunc(sysdate) "
			+ " order by question_date Desc  "
			+ " offset ((?-1)*5) rows "
			+ "  fetch first 5 rows only)";
	
	public final static String GETCREATORLISTPENDINGBYRANK = " select distinct users.*  from users join questions on users.user_id = questions.user_id "
			+ " where questions.question_id  in( "
			+ " select questions.question_id from questions "
			+ " where QUESTION_DATE >= trunc(sysdate) "
			+ " order by watches Desc   "
			+ " offset ((?-1)*5) rows "
			+ "  fetch first 5 rows only)";

	public final static String GETCREATORLISTFOLLOWINGBYYDATE = " select distinct users.*  from users join questions on users.user_id = questions.user_id "
			+ " where questions.question_id  in( "
			+ " select QUESTIONs.question_id from questions join user_choices on questions.question_id = user_Choices.question_id "
			+ " where user_choices.USER_ID = ? and QUESTIONS.QUESTION_DATE < trunc(sysdate) "
			+ " order by QUESTIONS.QUESTION_DATE DESC, QUESTIONS.QUESTION_SCORE DESC   "
			+ " offset ((?-1)*5) rows "
			+ "  fetch first 5 rows only)";
	
	public final static String GETCREATORLISTFOLLOWINGBYYRANK = " select distinct users.*  from users join questions on users.user_id = questions.user_id "
			+ " where questions.question_id  in( "
			+ " select QUESTIONs.question_id from questions join user_choices on questions.question_id = user_Choices.question_id "
			+ " where user_choices.USER_ID = ? and QUESTIONS.QUESTION_DATE < trunc(sysdate) "
			+ " order by QUESTIONS.QUESTION_SCORE DESC, QUESTIONS.QUESTION_DATE ASC "
			+ " offset ((?-1)*5) rows "
			+ "  fetch first 5 rows only)";
	
	


}
	
	public static class Question{
		
	public final static String  GETQUESTIONBYID = "SELECT * FROM QUESTIONS "
				+ "where QUESTION_ID = ? ";
	public final static String  DELETEQUESTION = "DELETE FROM QUESTIONS "
			+ "where QUESTION_ID = ? ";

	public final static String CREATEQUESTION = "insert into questions (user_id,question_text,question_date) "
			+ "values(?,?,sysdate)";
	
	public final static String INCUSERCREATED = "UPDATE USERS SET QUESTIONS_CREATED = QUESTIONS_CREATED + 1 "
			+ "where USER_ID = ?";
		
	public final static String GETQUESTIONBYDATE = "select * from questions "
			+ "where question_date >= (trunc(sysdate) - ?) and question_date < trunc(sysdate)- (?-1) "
			+ "order by question_score desc, question_date asc";

	public final static String GETQUESTIONARCHIVEBYRANK = " select * from questions " + 
			"where QUESTION_DATE < trunc(sysdate)-7 and QUESTION_DATE >= trunc(sysdate)-14 " + 
			"order by question_score desc, question_date asc " + 
			"offset ((?-1)*5) rows " + 
			" fetch first 5 rows only";
	
	public final static String GETQUESTIONBYRANK = " select * from questions " + 
			"where QUESTION_DATE < trunc(sysdate) and QUESTION_DATE >= trunc(sysdate)-7 " + 
			"order by question_score desc, question_date asc " + 
			"offset ((?-1)*5) rows " + 
			" fetch first 5 rows only";
	
	public final static String GETPENDINGQUESTIONBYDATE = " select * from questions " + 
			"where QUESTION_DATE >= trunc(sysdate)" + 
			"order by  question_date Desc " + 
			"offset ((?-1)*5) rows " + 
			" fetch first 5 rows only";
	
	
	public final static String GETPENDINGQUESTIONBYRANK = " select * from questions " + 
			"where QUESTION_DATE >= trunc(sysdate)" + 
			"order by  watches Desc " + 
			"offset ((?-1)*5) rows " + 
			" fetch first 5 rows only";
	
	public final static String GETPENDINGCOUNT = "select count(*) from questions " + 
			"where QUESTION_DATE >= trunc(sysdate)";
	
	
	public final static String GETFOLLOWINGQUESTIONSBYDATE = "select QUESTIONs.* from questions join user_choices on questions.question_id = user_Choices.question_id  " 
			+ "where user_choices.USER_ID = ? and QUESTIONS.QUESTION_DATE < trunc(sysdate) "
			+ "order by QUESTIONS.QUESTION_DATE DESC, QUESTIONS.QUESTION_SCORE DESC "
			+ "offset ((?-1)*5) rows " 
			+ "fetch first 5 rows only";
	
	public final static String GETFOLLOWINGQUESTIONSBYRANK = "select QUESTIONs.* from questions join user_choices on questions.question_id = user_Choices.question_id where " +
			"user_choices.USER_ID = ? and QUESTIONS.QUESTION_DATE < trunc(sysdate) "
			+ "order by QUESTIONS.QUESTION_SCORE DESC, QUESTIONS.QUESTION_DATE ASC "
			+ "offset ((?-1)*5) rows " 
			+ "fetch first 5 rows only";
	
	}
	
	public static class Option{
		
		public final static String CREATEOPTION = "insert into options(question_id,option_text) "
				+ "values(?,?)";
		
		public final static String GETOPTIONBYID = "SELECT * FROM options WHERE "
				+ "OPTION_ID = ?";
		
		public final static String DELETEOPTION = "DELETE options WHERE "
				+ "OPTION_ID = ?";
		
		public final static String  GETTOPOPTIONBYDATE = "SELECT OPTIONS.* FROM OPTIONS "
			+	" JOIN QUESTIONS ON QUESTIONS.QUESTION_ID = OPTIONS.QUESTION_ID "
			+	" where question_date >= (trunc(sysdate) - ?) and question_date < trunc(sysdate)- (?-1)";
		
		public final static String  GETTOPOPTIONARCHIVEBYDATE = "SELECT OPTIONS.* FROM OPTIONS "
				+	" JOIN QUESTIONS ON QUESTIONS.QUESTION_ID = OPTIONS.QUESTION_ID "
				+ 	"where question_date >= (trunc(sysdate) - (? + 7)) and question_date < trunc(sysdate)- (?+6)";
		
		
		public final static String  GETOPTIONBYQUESTIONID = "SELECT * FROM OPTIONS "
				+ "where QUESTION_ID = ? ";
		
		public final static String GETOPTIONSBYRANK = "	select options.* from options " + 
				"		join questions on options.QUESTION_ID = QUESTIONS.QUESTION_ID " + 
				"		where options.QUESTION_ID in(" + 
				"		select QUESTION_ID from questions" + 
				"		where QUESTION_DATE < trunc(sysdate) and QUESTION_DATE >= trunc(sysdate)-7 " + 
				"		order by question_score desc, question_date asc " + 
				"		offset ((?-1)*5) rows " + 
				"		fetch first 5 rows only)";
		
		public final static String GETARCHIVEOPTIONSBYRANK = " select options.* from options " + 
				"		join questions on options.QUESTION_ID = QUESTIONS.QUESTION_ID " + 
				"		where options.QUESTION_ID in(" + 
				"		select QUESTION_ID from questions" + 
				"		where QUESTION_DATE < trunc(sysdate)-7 and QUESTION_DATE >= trunc(sysdate)-14 " + 
				"		order by question_score desc, question_date asc " + 
				"		offset ((?-1)*5) rows " + 
				"		fetch first 5 rows only)";
		
		public final static String GETPENDINGOPTIONBYDATE = " select options.* from options "
				+ "join questions on options.QUESTION_ID = questions.QUESTION_ID " + 
				"  		  where options.question_id in( " + 
				"         select questions.question_id from questions " + 
				"			where QUESTION_DATE >= trunc(sysdate) " + 
				"			order by  question_date Desc " + 
				"			offset ((?-1)*5) rows " + 
				"			fetch first 5 rows only) ";
		
		public final static String GETPENDINGOPTIONBYRANK = " select options.* from options "
				+ "			join questions on options.QUESTION_ID = questions.QUESTION_ID " + 
				"  			  where options.question_id in( " + 
				"   		 select questions.question_id from questions " + 
				"			where QUESTION_DATE >= trunc(sysdate) " + 
				"			order by  watches Desc " + 
				"			offset ((?-1)*5) rows " + 
				"            fetch first 5 rows only)";
		
		public final static String GETFOLLOWINGOPTIONSBYDATE = "select options.* from options "
				+ " 	join questions on options.question_id = questions.question_id "
				+ "		where options.question_id in("
				+ " 	select QUESTIONs.question_id from questions join user_choices on questions.question_id = user_Choices.question_id where "
				+ " 	user_choices.USER_ID = ? and QUESTIONS.QUESTION_DATE < trunc(sysdate)  "
				+ " 	order by QUESTIONS.QUESTION_DATE DESC, QUESTIONS.QUESTION_SCORE DESC "
				+ " 	offset ((?-1)*5) rows  "
				+ " 	fetch next 5 rows only) ";
		
		public final static String GETFOLLOWINGOPTIONSBYRANK = "select options.* from options "
				+ " 	join questions on options.question_id = questions.question_id "
				+ "		where options.question_id in("
				+ " 	select QUESTIONs.question_id from questions join user_choices on questions.question_id = user_Choices.question_id where "
				+ " 	user_choices.USER_ID = ? and QUESTIONS.QUESTION_DATE < trunc(sysdate)  "
				+ " 	order by QUESTIONS.QUESTION_SCORE DESC, QUESTIONS.QUESTION_DATE ASC "
				+ " 	offset ((?-1)*5) rows  "
				+ " 	fetch next 5 rows only) ";
		
		
		}
		
		
	

	
	
	
	public static class Watching{


	public final static String ISWATCHING = "SELECT Question_Id FROM USER_WATCHING "
			+ "where USER_id = ?";
	
	public final static String WATCHQUESTION = "INSERT INTO USER_WATCHING (USER_ID, QUESTION_ID) " +
			"VALUES (?,?)"; 
	
	public final static String  UNWATCHQUESTION = "DELETE USER_WATCHING "
			+ "where USER_ID = ? AND QUESTION_ID = ?";
	
	public final static String INCWATCH = "UPDATE QUESTIONS SET WATCHES = WATCHES + 1 "
			+ "where question_id = ?";
	
	public final static String DECWATCH = "UPDATE QUESTIONS SET WATCHES = WATCHES - 1 "
			+ "where question_id = ?";
	
	public final static String INCUSERWATCH = "UPDATE USERS SET WATCHES = WATCHES + 1 "
			+ "where USER_ID = ?";
	
	public final static String DECUSERWATCH = "UPDATE USERS SET WATCHES = WATCHES - 1 "
			+ "where USER_ID = ?";
	
	public final static String WATCHINGCOUNT = "SELECT COUNT(*) "
			+ "FROM USER_WATCHING";
	
	
	
}
	
	public static class Choices{

	
	public final static String  GETUSERCHOICES = "SELECT QUESTION_ID,OPTION_ID FROM USER_CHOICES "
			+ "where USER_ID = ? ";
	
	
	public final static String  GETUSERCHOICESBYDATE = "select user_choices.* from user_choices join questions on user_choices.question_id = questions.question_id " + 
			"where user_choices.user_id = ? and questions.question_date >= (trunc(sysdate) - ?) and question_date < trunc(sysdate)- (?-1)";
	
	
	public final static String  GETUSERCHOICESBYRANK = "	SELECT USER_CHOICES.* FROM USER_CHOICES join questions on questions.question_id = USER_CHOICES.question_id " + 
			"			 where USER_CHOICES.USER_ID = ?  and USER_CHOICES.question_id in " + 
			"			(select QUESTION_ID from questions " + 
			"			where QUESTION_DATE < trunc(sysdate) and QUESTION_DATE >= trunc(sysdate)-7 " + 
			"			order by question_score desc, question_date asc " + 
			"			offset ((?-1)*5) rows " + 
			"			fetch first 5 rows only)";
	

	
	public final static String  CREATEUSERCHOICES = "INSERT INTO USER_CHOICES(USER_ID,QUESTION_ID,OPTION_ID) "
			+ "VALUES(?,?,?)";
	
	public final static String  INCQUESTIONSCORE = "UPDATE QUESTIONs SET QUESTION_SCORE = QUESTION_SCORE + 1 " + 
			"WHERE QUESTION_ID = ?";
	
	public final static String  DECQUESTIONSCORE = "UPDATE QUESTIONs SET QUESTION_SCORE = QUESTION_SCORE - 1 " + 
			"WHERE QUESTION_ID = ?";
	
	public final static String INCOPTIONSCORE = "UPDATE OPTIONS SET OPTION_SCORE = OPTION_SCORE + 1 " + 
			"WHERE OPTION_ID = ?";
	
	public final static String DECOPTIONSCORE = "UPDATE OPTIONS SET OPTION_SCORE = OPTION_SCORE - 1 " + 
			"WHERE OPTION_ID = ?";
	
	public final static String  UPDATEUSERCHOICES = "UPDATE USER_CHOICES SET OPTION_ID = ? "
			+ "WHERE USER_ID = ? AND QUESTION_ID = ? ";
	
	public final static String  GETUSERQCHOICES = "SELECT OPTION_ID FROM USER_CHOICES "
			+ "where USER_ID = ? and QUESTION_ID = ?";
			
	public final static String  DELETEUSERCHOICE = "DELETE FROM USER_CHOICES "
			+ "where USER_ID = ? and QUESTION_ID = ?";
	
	public final static String INCUSERFOLLOW = "UPDATE USERS SET CHOICES = CHOICES + 1 "
			+ "where USER_ID = ?";
	
	public final static String DECUSERFOLLOW = "UPDATE USERS SET CHOICES = CHOICES - 1 "
			+ "where USER_ID = ?";
	
	
	public final static String COUNTUSERFOLLOWING = "select count(*)  from Questions JOIN USER_CHOICES on questions.question_id = user_choices.question_id " + 
			" where QUESTIONS.QUESTION_DATE >= trunc(sysdate)-7 " + 
			" and USER_CHOICES.user_id = ? ";
	
	public final static String COUNTUSERFOLLOWINGARCHIVE = "select count(*)  from Questions JOIN USER_CHOICES on questions.question_id = user_choices.question_id " + 
			" where QUESTIONS.QUESTION_DATE < trunc(sysdate)-7 " + 
			" and USER_CHOICES.user_id = ? ";
			
	
}

	
	public static class Comments{
	
	public final static String  GETQUESTIONCOMMENT = "SELECT * FROM COMMENTS "
			+ "where QUESTION_ID = ? ";
	
	public final static String  CREATECOMMENT = "insert into comments(user_id,question_id,option_id,comment_text,comment_date) " 
			+ "values(?,?,?,?,sysdate)";
	
	public final static String  DELETECOMMENT = "DELETE FROM comments " 
			+ "where COMMENT_ID = ?";
	
	public final static String INCUSERCOMMENTS = "UPDATE USERS SET COMMENTS = COMMENTS + 1 "
			+ "where USER_ID = ?";
	}
}
