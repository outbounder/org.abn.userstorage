package org.abn.userstorage.operation;

import haxe.Stack;
import org.abn.bot.operation.BotOperation;
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
			
		this.botContext.openXMPPConnection(onConnected, onConnectFailed, onDisconnected);
		
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
		trace("userstorage connected");
	}
	
	private function onDisconnected():Void
	{
		if (this.botContext.has("started"))
		{
			trace("trying to reconnect...");
			this.botContext.openXMPPConnection(onConnected, onConnectFailed, onDisconnected);
		}
	}
}