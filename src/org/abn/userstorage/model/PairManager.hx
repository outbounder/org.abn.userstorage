package org.abn.userstorage.model;

import neko.db.Connection;
import neko.db.ResultSet;
import org.abn.neko.database.mysql.ManagerEx;

class PairManager extends ManagerEx<Pair>
{
    public function new(cnx:Connection) 
	{
        super(cnx, Pair);
    }
	
	public function queryStartWith(key:String,userID:String):List<Pair>
	{
		var keyMatch:String = key == null?"":this.quoteField("key") + " LIKE " + this.quote(key + "%");
		var userIDMatch:String = userID == null?"":this.quoteField("userId") + " = " + this.quote(userID);
		var selectQuery:String = keyMatch;
		if (selectQuery.length != 0 && userIDMatch.length != 0)
			selectQuery += " AND "+userIDMatch;
		else 
		if (userIDMatch.length != 0)
			selectQuery = userIDMatch;
		return objects(select(selectQuery));
	}
	
	public function queryAllUserPairsWithKey(key:String):List<Pair>
	{
		return objects("SELECT * FROM " + this.table_name + " WHERE userId IN (SELECT userId FROM " + this.table_name + " WHERE `key` LIKE '" + key + "%')");
	}
}