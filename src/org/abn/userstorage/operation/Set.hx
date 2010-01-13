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
			if ((params.get("key") == null || params.get("key") == "") || (params.get("userId") == null || params.get("userId") == ""))
				return this.formatResponse("NEEEDKEYUSERID", params.get('format'));
				
			var pairs:List<Pair> = pairManager.queryStartWith(params.get("key"),params.get("userId"), params.get("sourceId"));
			if (pairs.length > 1)
				return "can not set value to namespace " + params.get("key");
				
			var pair:Pair = pairs.first();
			if (pairs.length == 0 || pair == null)
				return this.formatResponse("NOTHINGDONE", params.get('format'));
				
			pairManager.delete( { id:pair.id } );
			return this.formatResponse("DELETED",params.get('format'));
		}
		else
		{
			var pairs:List<Pair> = pairManager.queryStartWith(params.get("key"),params.get("userId"), params.get("sourceId"));
			if (pairs.length > 1)
				return this.formatResponse("can not set value to namespace " + params.get("key"), params.get('format'));
				
			var pair:Pair = pairs.first();
			if (pair == null)
			{
				pair = new Pair();
				pair.key = params.get("key");
				pair.sourceId = params.get("sourceId");
				pair.userId = params.get("userId");
				pair.value = params.get("value");
				pairManager.insert(pair);
				
				return this.formatResponse("INSERTED",params.get('format'));
			}
			else 
			{
				pair.value = params.get("value");
				pair.userId = params.get("userId");
				pairManager.update(pair);
				
				return this.formatResponse("UPDATED", params.get('format'));
			}
		}
	}
}