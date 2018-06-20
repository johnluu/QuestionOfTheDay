package qofd.Dao.testcases;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

import java.sql.SQLException;
import java.util.List;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.Test;

import qofd.Dao.QuestionDAO;
import qofd.Models.Question;

public class QuestionDAOTest {

	@Test
	public void createQuestionTest() throws SQLException {
		QuestionDAO qDAO = new QuestionDAO();
		
		int userid = 1;
		String questiontext = "FavConsole";
		
		int qid = qDAO.createNewQuestion(userid, questiontext);
	
		Question question = qDAO.getQuestionById(qid);
		
		assertThat(question.getQuestion_id(), is(equalTo(qid)));
		assertThat(question.getUser_id(), is(equalTo(userid)));
		assertThat(question.getQuestion_text(), is(equalTo(questiontext)));

		
		assertThat(qDAO.deleteQuestion(qid), is(equalTo(true)));
		  
		qDAO.deleteQuestion(qid);
	}
	/*For the newly generated questions
	 * 
	 * 
	 */
	@Test
	public void QueryTests() throws SQLException {
		QuestionDAO qDAO = new QuestionDAO();
		
		List<Question> pendingListByDate = qDAO.getPendingByDate(0);
		System.out.println("PendingByDate");
		for(Question q:pendingListByDate)
			System.out.println(q.getQuestion_id());
		
		assertThat(pendingListByDate.get(0).getQuestion_id(), is(equalTo(71)));
		assertThat(pendingListByDate.get(1).getQuestion_id(), is(equalTo(72)));
		assertThat(pendingListByDate.get(2).getQuestion_id(), is(equalTo(73)));
		assertThat(pendingListByDate.get(3).getQuestion_id(), is(equalTo(74)));
		assertThat(pendingListByDate.get(4).getQuestion_id(), is(equalTo(75)));
		
		List<Question> pendingListByRank = qDAO.getPendingByRank(1);
		System.out.println("PendingByRank");
		for(Question q: pendingListByRank)
			System.out.println(q.getQuestion_id());
		
		assertThat(pendingListByRank.get(0).getQuestion_id(), is(equalTo(71)));
		assertThat(pendingListByRank.get(1).getQuestion_id(), is(equalTo(72)));
		assertThat(pendingListByRank.get(2).getQuestion_id(), is(equalTo(73)));
		assertThat(pendingListByRank.get(3).getQuestion_id(), is(equalTo(74)));
		assertThat(pendingListByRank.get(4).getQuestion_id(), is(equalTo(75)));
		
		List<Question> questionByDate = qDAO.getQuestionByDate(1);
		System.out.println("questionByDate");
		for(Question q: questionByDate)
			System.out.println(q.getQuestion_id());
		
		assertThat(questionByDate.get(0).getQuestion_id(), is(equalTo(70)));
		assertThat(questionByDate.get(1).getQuestion_id(), is(equalTo(69)));
		assertThat(questionByDate.get(2).getQuestion_id(), is(equalTo(68)));
		assertThat(questionByDate.get(3).getQuestion_id(), is(equalTo(67)));
		assertThat(questionByDate.get(4).getQuestion_id(), is(equalTo(66)));
		
		List<Question> questionByRank = qDAO.getQuestionByRank(1);
		System.out.println("questionByRank");
		for(Question q: questionByRank)
			System.out.println(q.getQuestion_id());
		
		assertThat(questionByRank.get(0).getQuestion_id(), is(equalTo(45)));
		assertThat(questionByRank.get(1).getQuestion_id(), is(equalTo(50)));
		assertThat(questionByRank.get(2).getQuestion_id(), is(equalTo(55)));
		assertThat(questionByRank.get(3).getQuestion_id(), is(equalTo(60)));
		assertThat(questionByRank.get(4).getQuestion_id(), is(equalTo(65)));
		
		List<Question> archivedQuestionByDate = qDAO.getQuestionByDate(8);
		System.out.println("archivedQuestionByDate");
		for(Question q: archivedQuestionByDate)
			System.out.println(q.getQuestion_id());
		
		assertThat(archivedQuestionByDate.get(0).getQuestion_id(), is(equalTo(36)));
		assertThat(archivedQuestionByDate.get(1).getQuestion_id(), is(equalTo(37)));
		assertThat(archivedQuestionByDate.get(2).getQuestion_id(), is(equalTo(38)));
		assertThat(archivedQuestionByDate.get(3).getQuestion_id(), is(equalTo(39)));
		assertThat(archivedQuestionByDate.get(4).getQuestion_id(), is(equalTo(40)));
		
		List<Question> archivedQuestionByRank = qDAO.getArchiveQuestionByRank(1);
		System.out.println("archivedQuestionByRank");
		for(Question q: archivedQuestionByRank)
			System.out.println(q.getQuestion_id());
		
		assertThat(archivedQuestionByRank.get(0).getQuestion_id(), is(equalTo(10)));
		assertThat(archivedQuestionByRank.get(1).getQuestion_id(), is(equalTo(15)));
		assertThat(archivedQuestionByRank.get(2).getQuestion_id(), is(equalTo(20)));
		assertThat(archivedQuestionByRank.get(3).getQuestion_id(), is(equalTo(25)));
		assertThat(archivedQuestionByRank.get(4).getQuestion_id(), is(equalTo(30)));
		
		Question questionbyid = qDAO.getQuestionById(1);
		assertThat(questionbyid.getQuestion_id(), is(equalTo(1)));

		
		
	}
	
}
