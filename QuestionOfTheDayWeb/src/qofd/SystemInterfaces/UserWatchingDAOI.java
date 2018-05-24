package qofd.SystemInterfaces;

import java.sql.SQLException;
import java.util.HashSet;

public interface UserWatchingDAOI {

	public int watch(int userid, int questionid) throws SQLException;
	public int unwatch(int userid, int questionid);
	public HashSet<Integer> isWatching(int userid);
	
}