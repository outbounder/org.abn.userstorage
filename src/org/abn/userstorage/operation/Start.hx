package org.abn.userstorage.operation;

import haxe.Stack;
import org.abn.bot.operation.BotOperation;
import org.abn.bot.operation.BotOperationListener;
import org.abn.neko.xmpp.XMPPContext;
import org.abn.userstorage.Main;

import neko.Web;
import xmpp.Message;
import haxe.xml.Fast;

class Start extends BotOperation
{		
	public override function execute(params:Hash<String>):String
	{
		if (this.botContext.has("started"))
			return "already started";
			
		var xmppContext:XMPPContext = this.botContext.getXMPPContext();
		xmppContext.openConnection(true, onConnected, onDisconnected, onConnectFailed);
		
		Web.cacheModule(Main.handleRequests);
		this.botContext.set("started", true);
		return "done";
	}
	
	private function onConnectFailed(reason:Dynamic):Void
	{
		this.botContext.set("started", null);
		trace("xmpp connect failed "+reason);
	}
	
	private function onConnected():Void
	{
		var operationListener:BotOperationListener = new BotOperationListener(this.botContext);
		trace("userstorage connected");
	}
	
	private function onDisconnected():Void
	{
		if (this.botContext.has("started"))
		{
			trace("trying to reconnect...");
			var xmppContext:XMPPContext = this.botContext.getXMPPContext();
			xmppContext.openConnection(false, onConnected, onDisconnected);
		}
	}
}