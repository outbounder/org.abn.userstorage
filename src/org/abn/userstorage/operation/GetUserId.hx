package org.abn.userstorage.operation;

import haxe.Md5;
import org.abn.userstorage.UserStorageOperation;

class GetUserId extends UserStorageOperation
{
	public override function execute(params:Hash<String>):String
	{
		var username:String = params.get("username");
		var password:String = params.get("password");
		var meta:String = username + password;
		return "<response>"+Md5.encode(meta)+"</response>";
	}
}