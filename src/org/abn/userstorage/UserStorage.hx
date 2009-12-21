package org.abn.userstorage;

import haxe.xml.Fast;
import neko.Lib;
import neko.Web;
import org.abn.Context;
import org.abn.neko.AppContext;
import org.abn.neko.database.mysql.MySqlContext;
import org.abn.neko.xmpp.XMPPContext;

import xmpp.Message;

class UserStorage extends AppContext
{	
	public function new(context:AppContext) 
	{
		super(context.properties);
	}
	
	public function getXMPPContext():XMPPContext
	{
		if (!this.has("xmpp"))
			this.set("xmpp", this.createXMPPContext("userstorage"));
			
		return this.get("xmpp");
	}
	
	public function getDatabase():MySqlContext
	{
		if (!this.has("database"))
			this.set("database", this.createDatabaseContext("database"));
		return this.get("database");
	}
	
	public function getOperationFactory():UserStorageOperationFactory
	{
		if (!this.has("operationFactory"))
			this.set("operationFactory", new UserStorageOperationFactory(this));
		return this.get("operationFactory");
	}
	
	public function executeOperation(id:String, params:Hash<String>):String
	{
		var operation:UserStorageOperation = this.getOperationFactory().getOperationById(id);
		return operation.execute(params);
	}
	
}