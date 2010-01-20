package org.abn.userstorage.operation;

import org.abn.uberTora.UberToraContext;
import org.abn.bot.operation.BotOperation;

class Stop extends BotOperation
{
	public override function execute(params:Hash<String>):String
	{		
		if (!this.botContext.has("started"))
			return "<response>not started</response>";
		
		this.botContext.set("started", null);
		this.botContext.closeXMPPConnection();
		UberToraContext.redirectRequests(null);
		
		return "<response>stopped</response>";
	}
}