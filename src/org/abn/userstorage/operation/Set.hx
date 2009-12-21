package org.abn.userstorage.operation;
import neko.db.ResultSet;
import org.abn.userstorage.UserStorageOperation;

class Set extends UserStorageOperation
{
	public override function execute(params:Hash<String>):String
	{
		if (params.get("value") != "" && params.get("value") != null)
		{
			var query:String = "INSERT INTO " + this.appContext.get("database.tables.users.name")+" ";
			var columns:Array<String> = new Array();
			var values:Array<String> = new Array();
			for (key in params.keys())
			{
				columns.push("`"+key+"`");
				values.push(this.getDbConn().quote(params.get(key)));
			}
			query += "(" + columns.join(",") + ") VALUES(" + values.join(",") + ")";
			this.getDbConn().request(query);
			if (this.getDbConn().lastInsertId() > 0)
				return "OK";
			else
				return "FAILED";
		}
		else
		{
			var query:String = "DELETE FROM " + this.appContext.get("database.tables.user.name")+" WHERE ";
			var parts:Array<String> = new Array();
			for (key in params.keys())
				parts.push(key+" = "+this.getDbConn().quote(params.get(key)));
			query += parts.join("AND");
			var result:ResultSet = this.getDbConn().request(query);
			return "<response>OK</response>";
		}
	}
}