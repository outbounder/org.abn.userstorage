package org.abn.userstorage.operation;
import org.abn.userstorage.model.Pair;
import org.abn.userstorage.UserStorageOperation;

class Get extends UserStorageOperation
{
	public override function execute(params:Hash<String>):String
	{
		var pairs:List < Pair > = Pair.manager.queryStartWith(params.get("key"), params.get("userID"));
		var pairsAsXML:Array<String> = new Array();
		var pair:Pair;
		for (pair in pairs)
			pairsAsXML.push("<pair><key>" + pair.key + "</key><value>" + pair.value + "</value></pair>");
		return "<response>" + pairsAsXML.join("") + "</response>";
	}
}