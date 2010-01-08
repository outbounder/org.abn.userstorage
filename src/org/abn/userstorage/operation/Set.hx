package org.abn.userstorage.operation;
import neko.db.ResultSet;
import org.abn.bot.operation.BotOperation;
import org.abn.neko.database.mysql.MySqlContext;
import org.abn.userstorage.model.Pair;
import org.abn.userstorage.model.PairManager;


class Set extends BotOperation
{
	public override function execute(params:Hash<String>):String
	{
		var pairManager:PairManager = new PairManager(this.getDbConn());
		if (params.get("value") == "" || params.get("value") == null)
		{
			var pairs:List<Pair> = pairManager.queryStartWith(params.get("key"),params.get("userId"), params.get("sourceId"));
			if (pairs.length > 1)
				return "can not set value to namespace "+params.get("key");
			var pair:Pair = pairs.first();
			pairManager.delete(pair);
			return "<response>DELETED</response>";
		}
		else
		{
			var pairs:List<Pair> = pairManager.queryStartWith(params.get("key"),params.get("userId"), params.get("sourceId"));
			if (pairs.length > 1)
				return "can not set value to namespace "+params.get("key");
			var pair:Pair = pairs.first();
			if (pair == null)
			{
				pair = new Pair();
				pair.key = params.get("key");
				pair.sourceId = params.get("sourceId");
				pair.userId = params.get("userId");
				pair.value = params.get("value");
				pairManager.insert(pair);
				return "<response>INSERTED</response>";
			}
			else 
			{
				pair.value = params.get("value");
				pair.userId = params.get("userId");
				pairManager.update(pair);
				return "<response>UPDATED</response>";
			}
		}
	}
}