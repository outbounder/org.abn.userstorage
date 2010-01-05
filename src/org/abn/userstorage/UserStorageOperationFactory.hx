﻿package org.abn.userstorage;

import neko.vm.Module;
import org.abn.bot.BotContext;
import org.abn.bot.operation.BotOperationFactory;
import org.abn.userstorage.UserStorage;

import org.abn.userstorage.operation.Start;
import org.abn.userstorage.operation.Stop;
import org.abn.userstorage.operation.Get;
import org.abn.userstorage.operation.GetUserId;
import org.abn.userstorage.operation.Set;
import org.abn.userstorage.operation.StatusReport;

class UserStorageOperationFactory extends BotOperationFactory
{
	public function new(botContext:BotContext) 
	{
		super(botContext);
	}
}