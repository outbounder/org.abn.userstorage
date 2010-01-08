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
	
	public function queryStartWith(key:String,userID:String,sourceId:String):List<Pair>
	{
		var whereParts:Array<String> = new Array();
		
		if (key != null)
			whereParts.push(this.quoteField("key") + " LIKE " + this.quote(key + "%"));
		if (userID != null)
			whereParts.push(this.quoteField("userId") + " = " + this.quote(userID));
		if (sourceId != null)
			whereParts.push(this.quoteField("sourceId") + " = " + this.quote(sourceId));
			
		var selectQuery:String = whereParts.join(" AND ");
			
		if(selectQuery.length != 0)
			return objects("SELECT * FROM " + this.table_name + " WHERE "+selectQuery);
		else
			return objects("SELECT * FROM " + this.table_name);
	}
	
	public function queryAllUserPairsWithKey(key:String):List<Pair>
	{
		return objects("SELECT * FROM " + this.table_name + " WHERE userId IN (SELECT userId FROM " + this.table_name + " WHERE `key` LIKE '" + key + "%')");
	}
}