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
	public List<Option> getOptionsByQuestionId(int questionid) throws SQLException {
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		List <Option> questionOption = new ArrayList<Option>();
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Option.GETOPTIONBYQUESTIONID);
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
	
	@Override
	public Option getOptionById(int optionid) throws SQLException {
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		Option option= null;
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Option.GETOPTIONBYID);
			stmt.setInt(1, optionid);
			result = stmt.executeQuery();
			
			if(result.next())
				option = new Option(result.getInt(1),result.getInt(2),result.getString(3), result.getInt(4));
				
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
		
		return option;
		
	}
	
	@Override
	public boolean deleteOption(int optionid) throws SQLException {
		
		Connection conn = null;
		PreparedStatement stmt = null;
		int result = 0;
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Option.DELETEOPTION);
			stmt.setInt(1, optionid);
			result = stmt.executeUpdate();
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(conn != null)
			conn.close();
		if(stmt != null)
			stmt.close();
		
		return result>0;
		
	}
	@Override
	public HashMap<Integer,List<Option>> getOptionByDate(int dateOffset) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer, List<Option>> TopOptions = new HashMap<Integer, List<Option>>();
		
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Option.GETTOPOPTIONBYDATE);
			stmt.setInt(1, dateOffset);
			stmt.setInt(2, dateOffset);
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
	
	
	@Override
	public HashMap<Integer,List<Option>> getFollowingOptionByDate(int userid, int offset) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer, List<Option>> FollowingOptions = new HashMap<Integer, List<Option>>();
		
		
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Option.GETFOLLOWINGOPTIONSBYDATE);
			stmt.setInt(1, userid);
			stmt.setInt(2, offset);
			result = stmt.executeQuery();
			
			while(result.next())
			{	
				Option option = new Option(result.getInt(1),result.getInt(2),result.getString(3), result.getInt(4));
				List <Option> questionOption = FollowingOptions.get(result.getInt(2));
				if(questionOption == null)
				{
					questionOption = new ArrayList<Option>();
					FollowingOptions.put(result.getInt(2), questionOption);
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
		
		return FollowingOptions;
	
	
}
	
	
	@Override
	public HashMap<Integer,List<Option>> getFollowingOptionByRank(int userid, int offset) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer, List<Option>> FollowingOptions = new HashMap<Integer, List<Option>>();
		
		
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Option.GETFOLLOWINGOPTIONSBYRANK);
			stmt.setInt(1, userid);
			stmt.setInt(2, offset);
			result = stmt.executeQuery();
			
			while(result.next())
			{	
				Option option = new Option(result.getInt(1),result.getInt(2),result.getString(3), result.getInt(4));
				List <Option> questionOption = FollowingOptions.get(result.getInt(2));
				if(questionOption == null)
				{
					questionOption = new ArrayList<Option>();
					FollowingOptions.put(result.getInt(2), questionOption);
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
		
		return FollowingOptions;
	
	
}
	
	
	@Override
	public HashMap<Integer,List<Option>> getOptionArchiveByDate(int dateOffset) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer, List<Option>> TopOptions = new HashMap<Integer, List<Option>>();
		
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Option.GETTOPOPTIONARCHIVEBYDATE);
			stmt.setInt(1, dateOffset);
			stmt.setInt(2, dateOffset);
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
	
	
	
	
	
	@Override
	public int createOption(int questionid, String option_text) {
			
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		Integer id = null;
		String col[] = {"option_id"};

		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Option.CREATEOPTION,col);
			stmt.setInt(1, questionid);
			stmt.setString(2, option_text);
			stmt.executeUpdate();
			result = stmt.getGeneratedKeys();

			
			if(result.next())
			{
				id = result.getInt(1);
				System.out.println(id);
			}
			
		} catch (ClassNotFoundException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
			
			

		return id;
	}

	@Override
	public HashMap<Integer, List<Option>> getOptionsByRank(int rowOffset) throws SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer, List<Option>> TopOptions = new HashMap<Integer, List<Option>>();
		
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Option.GETOPTIONSBYRANK);
			stmt.setInt(1, rowOffset);
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
	
	@Override
	public HashMap<Integer, List<Option>> getArchiveOptionsByRank(int rowOffset) throws SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer, List<Option>> TopOptions = new HashMap<Integer, List<Option>>();
		
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Option.GETARCHIVEOPTIONSBYRANK);
			stmt.setInt(1, rowOffset);
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
	
	@Override
	public HashMap<Integer, List<Option>> getPendingOptionsByDate(int rowOffset) throws SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer, List<Option>> TopOptions = new HashMap<Integer, List<Option>>();
		
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Option.GETPENDINGOPTIONBYDATE);
			stmt.setInt(1, rowOffset);
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
	
	@Override
	public HashMap<Integer, List<Option>> getPendingOptionsByRank(int rowOffset) throws SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HashMap<Integer, List<Option>> TopOptions = new HashMap<Integer, List<Option>>();
		
		
		try {
			conn = OracleConnection.getConnection();
			stmt = conn.prepareStatement(OracleQueries.Option.GETPENDINGOPTIONBYRANK);
			stmt.setInt(1, rowOffset);
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
