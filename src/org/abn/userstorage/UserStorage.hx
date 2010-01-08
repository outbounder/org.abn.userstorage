package org.abn.userstorage;

import org.abn.bot.BotContext;
import org.abn.neko.AppContext;

import org.abn.userstorage.operation.Start;
import org.abn.userstorage.operation.Stop;
import org.abn.userstorage.operation.Get;
import org.abn.userstorage.operation.GetUserId;
import org.abn.userstorage.operation.Set;
import org.abn.userstorage.operation.StatusReport;
import org.abn.userstorage.operation.GetUserPairs;

class UserStorage extends BotContext
{	
	public function new(context:AppContext) 
	{
		super(context);
	}
}