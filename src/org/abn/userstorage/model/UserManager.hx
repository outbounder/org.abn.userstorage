package org.abn.userstorage.model;
import neko.db.Connection;
import org.abn.neko.database.mysql.ManagerEx;

class UserManager extends ManagerEx<User>
{

	public function new(cnx:Connection) 
	{
		super(cnx,User);
	}
	
	public function getUserByUsername(username:String):User
	{
		return object("SELECT * FROM " + this.table_name + " WHERE username = '" + username + "' LIMIT 1");
	}
}