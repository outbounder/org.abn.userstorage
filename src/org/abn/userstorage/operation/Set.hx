package org.abn.userstorage.operation;
import neko.db.ResultSet;
import org.abn.bot.operation.BotOperation;
import org.abn.userstorage.model.Pair;


class Set extends BotOperation
{
	public override function execute(params:Hash<String>):String
	{
		if (params.get("value") == "" || params.get("value") == null)
		{
			var pair:Pair = new Pair();
			pair.key = params.get("key");
			pair.sourceId = params.get("sourceId");
			Pair.manager.delete(pair);
			return "<response>DELETED</response>";
		}
		else
		{
			var pairs:List<Pair> = Pair.manager.queryStartWith(params.get("key"),params.get("userId"));
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
				pair.insert();
				return "<response>INSERTED</response>";
			}
			else 
			{
				pair.value = params.get("value");
				pair.userId = params.get("userId");
				pair.update();
				return "<response>UPDATED</response>";
			}
		}
	}
}