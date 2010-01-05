package org.abn.userstorage.operation;
import neko.Web;
import org.abn.bot.operation.BotOperation;
import org.abn.bot.operation.BotOperationListener;


class Stop extends BotOperation
{
	public override function execute(params:Hash<String>):String
	{
		if (!this.botContext.has("started"))
			return "not started";
		if (this.botContext.has("operationListener"))
		{
			var listener:BotOperationListener = this.botContext.get("operationListner");
			listener.stopListening();
			this.botContext.set("operationListener", null);
		}
		this.botContext.set("started", null);
		this.botContext.closeXMPPConnection();
		this.botContext.resetDatabase();
		
		Web.cacheModule(null);
		return "done";
	}
}