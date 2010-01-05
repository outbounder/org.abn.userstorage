package org.abn.userstorage;

import haxe.xml.Fast;
import neko.Lib;
import neko.Web;
import org.abn.bot.BotContext;
import org.abn.bot.operation.BotOperation;
import org.abn.bot.operation.BotOperationFactory;
import org.abn.Context;
import org.abn.neko.AppContext;
import org.abn.neko.database.mysql.MySqlContext;
import org.abn.neko.xmpp.XMPPContext;
import org.abn.userstorage.model.Pair;

import xmpp.Message;

class UserStorage extends BotContext
{	
	public function new(context:AppContext) 
	{
		super(context);
		
		this.getDatabase();
		Pair.manager.updateTable();
	}
	
	public override function getOperationFactory():BotOperationFactory
	{
		if (!this.has("operationFactory"))
			this.set("operationFactory", new UserStorageOperationFactory(this));
		return this.get("operationFactory");
	}
	
}