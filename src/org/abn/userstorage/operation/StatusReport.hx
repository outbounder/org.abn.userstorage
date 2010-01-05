package org.abn.userstorage.operation;
import org.abn.bot.operation.BotOperation;

class StatusReport extends BotOperation
{
	public override function execute(params:Hash<String>):String
	{
		return "<online />";
	}
	
}