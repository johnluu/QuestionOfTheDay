package qofd.Dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import qofd.Models.Option;
import qofd.SystemInterfaces.OptionsDAOI;
import qofd.Utils.OracleQueries;

public class OptionDAO implements OptionsDAOI{

	@Override
	public List<Option> getQuestionOption(int questionid) throws SQLException {
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List <Option> questionOption = new ArrayList<Option>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.GETQUESTIONOPTION);
			stmt.setInt(1, questionid);
			result = stmt.executeQuery();
			
			while(result.next())
				questionOption.add(new Option(result.getInt(1),result.getInt(2),result.getString(3), result.getInt(4)));
				
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(result != null)
			result.close();
		if(stmt != null)
			stmt.close();
		
		return questionOption;
		
	}

	public HashMap<Integer,List<Option>> getTopOption() throws SQLException 
	{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer, List<Option>> TopOptions = new HashMap<Integer, List<Option>>();
		
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.GETTOPOPTIONS);
			result = stmt.executeQuery();
			
			while(result.next())
			{	
				Option option = new Option(result.getInt(1),result.getInt(2),result.getString(3), result.getInt(4));
				List <Option> questionOption = TopOptions.get(result.getInt(2));
				if(questionOption == null)
				{
					questionOption = new ArrayList<Option>();
					TopOptions.put(result.getInt(2), questionOption);
				}
				questionOption.add(option);
				
			}
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(result != null)
			result.close();
		if(stmt != null)
			stmt.close();
		
		return TopOptions;
		
		
	}
	
	
}
