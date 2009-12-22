package org.abn.userstorage.operation;
import neko.Web;
import org.abn.userstorage.UserStorageOperation;

class Stop extends UserStorageOperation
{
	public override function execute(params:Hash<String>):String
	{
		if (!this.appContext.has("started"))
			return "not started";
			
		this.appContext.set("started", null);
		this.appContext.closeXMPPConnection();
		this.appContext.resetDatabase();
		
		Web.cacheModule(null);
		return "done";
	}
}