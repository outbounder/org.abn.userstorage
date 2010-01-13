package org.abn.userstorage.operation;

import haxe.Md5;
import org.abn.bot.operation.BotOperation;
import org.abn.userstorage.model.User;
import org.abn.userstorage.model.UserManager;


class GetUserId extends BotOperation
{
	public override function execute(params:Hash<String>):String
	{
		var userManager:UserManager = new UserManager(this.getDbConn());
		var user:User = userManager.getUserByUsername(params.get("username"));
		
		if (!params.exists("password"))
		{
			if(user != null)
				return this.formatResponse(user.userUID, params.get("format"));
			else
				return this.formatResponse("", params.get("format"));
		}
		else
		{
			if (user == null)
			{
				var username:String = params.get("username");
				var password:String = params.get("password");
				
				user = new User();
				user.userUID = Md5.encode(username + password);
				user.username = username;
				user.password = Md5.encode(password);
				userManager.insert(user);
				
				return this.formatResponse(user.userUID, params.get("format"));
			}
			else
			{
				if (Md5.encode(params.get("password")) == user.password)
					return this.formatResponse(user.userUID, params.get("format"));
				else
					return this.formatResponse("", params.get("format"));
			}
		}
	}
}