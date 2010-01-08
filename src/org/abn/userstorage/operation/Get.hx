package org.abn.userstorage.operation;
import org.abn.bot.operation.BotOperation;
import org.abn.neko.database.mysql.MySqlContext;
import org.abn.userstorage.model.Pair;
import org.abn.userstorage.model.PairManager;


class Get extends BotOperation
{
	public override function execute(params:Hash<String>):String
	{
		var pairManager:PairManager = new PairManager(this.getDbConn());
		var pairs:List < Pair > = pairManager.queryStartWith(params.get("key"), params.get("userId"), params.get("sourceId"));
		var pairsAsXML:Array<String> = new Array();
		var pair:Pair;
		for (pair in pairs)
			pairsAsXML.push("<pair><userId>" + pair.userId + "</userId><key>" + pair.key + "</key><value>" + pair.value + "</value></pair>");
		return "<response>" + pairsAsXML.join("") + "</response>";
	}
}