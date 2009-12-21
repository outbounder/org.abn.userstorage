package org.abn.userstorage.operation;

import haxe.Stack;
import org.abn.neko.xmpp.XMPPContext;
import org.abn.userstorage.Main;
import org.abn.userstorage.UserStorageOperation;
import neko.Web;
import xmpp.Message;
import haxe.xml.Fast;

class Start extends UserStorageOperation
{		
	public override function execute(params:Hash<String>):String
	{
		if (this.appContext.has("started"))
			return "already started";
			
		var xmppContext:XMPPContext = this.appContext.getXMPPContext();
		xmppContext.openConnection(true, onConnected);
		Web.cacheModule(Main.handleRequests);
		this.appContext.set("started", true);
		return "done";
	}
	
	private function onConnected():Void
	{
		this.appContext.getXMPPContext().getConnection().addMessageListener(incomingMessagesHandler);
	}
	
	private function incomingMessagesHandler(msg:Dynamic):Void
	{
		if (Std.is(msg, Message))
		{
			trace("incoming " + msg);
			try
			{
				var msg:Message = cast(msg, Message); 
				
				if (msg.body != null)
				{
					var body:String = msg.body.split("&lt;").join("<").split("&gt;").join(">");
					
					var xml:Xml = Xml.parse(body);
					
					if (xml != null)
					{
						var fast:Fast = new Fast(xml.firstElement());
						if (!fast.has.id)
							return;
							
						var operation:UserStorageOperation = this.appContext.getOperationFactory().getOperationById(fast.att.id);
						var result:String = operation.execute(this.appContext.getOperationFactory().getOperationParamsFromXML(fast));
						result = result.split("<").join("&lt;").split(">").join("&gt;");
						this.appContext.getXMPPContext().getConnection().sendMessage(msg.from, result);
					}
				}
			}
			catch (e:Dynamic)
			{
				trace(e);
				trace(Stack.toString(Stack.exceptionStack()));
				trace(msg);
			}
		}
	}
}