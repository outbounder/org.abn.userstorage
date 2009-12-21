package org.abn.userstorage;

import haxe.xml.Fast;
import neko.Lib;
import neko.Web;
import org.abn.Context;
import org.abn.neko.AppContext;
import org.abn.neko.database.mysql.MySqlContext;
import org.abn.neko.xmpp.XMPPContext;
import org.abn.userstorage.model.Pair;

import xmpp.Message;

class UserStorage extends AppContext
{	
	public function new(context:AppContext) 
	{
		super(context.properties);
		this.getDatabase();
		Pair.manager.updateTable();
	}
	
	public function getXMPPContext():XMPPContext
	{
		if (!this.has("xmpp"))
			this.set("xmpp", this.createXMPPContext("xmpp"));
			
		return this.get("xmpp");
	}
	
	public function closeXMPPConnection()
	{
		this.getXMPPContext().closeConnection();
		this.set("xmpp", null);
	}
	
	public function getDatabase():MySqlContext
	{
		if (!this.has("database"))
		{
			var dbContext:MySqlContext = this.createDatabaseContext("database");
			this.set("database", dbContext);
			neko.db.Manager.cnx = dbContext.getConnection();
			neko.db.Manager.initialize();
		}
		return this.get("database");
	}
	
	public function resetDatabase():Void
	{
		this.set("database", null);
		neko.db.Manager.cleanup();
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