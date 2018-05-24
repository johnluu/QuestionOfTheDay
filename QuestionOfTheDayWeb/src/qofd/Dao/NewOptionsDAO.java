package qofd.Dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import qofd.Models.New_Option;
import qofd.SystemInterfaces.NewOptionsDAOI;
import qofd.Utils.OracleQueries;

public class NewOptionsDAO implements NewOptionsDAOI{

	@Override
	public List<New_Option> getNewQuestionOption(int questionid) {
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List <New_Option> questionOption = new ArrayList<New_Option>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.GETNEWQUESTIONOPTION);
			stmt.setInt(1, questionid);
			result = stmt.executeQuery();
			
			while(result.next())
				questionOption.add(new New_Option(result.getInt(1),result.getInt(2),result.getString(3)));
				
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return questionOption;
	}

	@Override
	public boolean createNewOption(int questionid, String option_text) {
			
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.CREATEOPTION);
			stmt.setInt(1, questionid);
			stmt.setString(2, option_text);
			stmt.executeUpdate();
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
			
			

		return false;
	}

}
