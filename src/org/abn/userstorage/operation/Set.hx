package org.abn.userstorage.operation;
import neko.db.ResultSet;
import org.abn.userstorage.model.Pair;
import org.abn.userstorage.UserStorageOperation;

class Set extends UserStorageOperation
{
	public override function execute(params:Hash<String>):String
	{
		trace(params);
		if (params.get("value") == "" || params.get("value") == null)
		{
			var pair:Pair = new Pair();
			pair.key = params.get("key");
			pair.sourceID = params.get("sourceID");
			Pair.manager.delete(pair);
			return "<response>DELETED</response>";
		}
		else
		{
			var pairs:List<Pair> = Pair.manager.queryStartWith(params.get("key"),params.get("userID"));
			if (pairs.length > 1)
				return "can not set value to namespace "+params.get("key");
			var pair:Pair = pairs.first();
			if (pair == null)
			{
				pair = new Pair();
				pair.key = params.get("key");
				pair.sourceID = params.get("sourceID");
				pair.userID = params.get("userID");
				pair.value = params.get("value");
				pair.insert();
				return "<response>INSERTED</response>";
			}
			else 
			{
				pair.value = params.get("value");
				pair.update();
				return "<response>UPDATED</response>";
			}
		}
	}
}