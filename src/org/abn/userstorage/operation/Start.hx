package org.abn.userstorage.operation;

import haxe.Stack;
import neko.vm.Thread;
import org.abn.bot.operation.BotOperation;
import org.abn.neko.xmpp.XMPPContext;
import org.abn.userstorage.Main;
import org.abn.userstorage.model.PairManager;

import neko.Web;
import xmpp.Message;
import haxe.xml.Fast;

class Start extends BotOperation
{		
	private var httpThread:Thread;
	
	public override function execute(params:Hash<String>):String
	{
		if (this.botContext.has("started"))
			return "already started";
			
		this.botContext.openXMPPConnection(onConnected, onConnectFailed, onDisconnected);
		
		var pairManager:PairManager = new PairManager(this.getDbConn());
		pairManager.updateTable();
		
		Web.cacheModule(Main.handleRequests);
		this.botContext.set("started", true);
		
		this.httpThread = Thread.current();
		return "<response>"+Thread.readMessage(true)+"</response>";
	}
	
	private function onConnectFailed(reason:Dynamic):Void
	{
		this.botContext.set("started", null);
		trace("xmpp connect failed "+reason);
	}
	
	private function onConnected():Void
	{
		trace("userstorage connected");
		this.httpThread.sendMessage("started");
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