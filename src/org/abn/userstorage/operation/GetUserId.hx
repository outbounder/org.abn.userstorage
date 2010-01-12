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
				return "<response>" + user.userUID + "</response>";
			else
				return "<response />";
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
				
				return "<response>" + user.userUID + "</response>";
			}
			else
			{
				if (Md5.encode(params.get("password")) == user.password)
					return "<response>" + user.userUID + "</response>";
				else
					return "<response />";
			}
		}
	}
}