package qofd.Dao.testcases;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

import java.sql.SQLException;
import java.util.List;

import org.junit.Test;

import qofd.Dao.CommentDAO;
import qofd.Models.Comments;

public class CommentDAOTest {

	@Test
	public void userChoiceTest() throws SQLException {
		CommentDAO cDAO = new CommentDAO();
		Comments comment = new Comments(1,80,240,"HELLO MISTER");
		int commentid = cDAO.createComment(comment);
		List<Comments> commentList = cDAO.getQuestionComments(80);
		assertThat(commentList.get(0).getComment_id(), is(equalTo(commentid)));
		assertThat(commentList.get(0).getUser_id(), is(equalTo(1)));
		assertThat(commentList.get(0).getQuestion_id(), is(equalTo(80)));
		assertThat(commentList.get(0).getOption_id(), is(equalTo(240)));
		assertThat(commentList.get(0).getComment_text(), is(equalTo("HELLO MISTER")));
		assertThat(cDAO.deleteComment(commentid), is(equalTo(true)));
	}
}
