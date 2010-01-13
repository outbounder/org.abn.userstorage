package org.abn.userstorage.operation;
import org.abn.bot.operation.BotOperation;
import org.abn.userstorage.model.Pair;
import org.abn.userstorage.model.PairManager;

class GetUserPairs extends BotOperation
{

	public override function execute(params:Hash<String>):String
	{
		var pairManager:PairManager = new PairManager(this.getDbConn());
		var pairs:List < Pair > = pairManager.queryAllUserPairsWithKey(params.get("key"));
		
		if (params.get("format") == "json")
			return this.formatResponse(pairs, "json");
		
		var pairsAsXML:Array<String> = new Array();
		var pair:Pair;
		for (pair in pairs)
			pairsAsXML.push("<pair><userId>" + pair.userId + "</userId><key>" + pair.key + "</key><value>" + pair.value + "</value></pair>");
		return "<response>" + pairsAsXML.join("") + "</response>";
	}
	
}