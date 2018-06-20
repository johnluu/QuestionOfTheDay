package qofd.SystemInterfaces;

import java.sql.SQLException;
import java.util.HashSet;

public interface UserWatchingDAOI {

	public int watch(int userid, int questionid) throws SQLException;
	public boolean unwatch(int userid, int questionid) throws SQLException;
	public HashSet<Integer> isWatching(int userid) throws SQLException;
	public Integer getWatchCount() throws SQLException;
	
}