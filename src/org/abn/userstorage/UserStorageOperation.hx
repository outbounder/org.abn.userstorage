package org.abn.userstorage;
import neko.db.Connection;
import org.abn.neko.database.mysql.MySqlContext;

class UserStorageOperation
{
	public var appContext:UserStorage;
	
	public function new(appContext:UserStorage)
	{
		this.appContext = appContext;
	}
	
	public function getDbConn():Connection
	{
		return this.appContext.getDatabase().getConnection();
	}
	
	public function execute(params:Hash<String>):String
	{
		return "not implemented";
	}
}