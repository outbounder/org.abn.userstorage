package org.abn.userstorage;

import neko.vm.Module;
import org.abn.userstorage.UserStorage;

import haxe.xml.Fast;
import org.abn.userstorage.operation.Start;
import org.abn.userstorage.operation.Stop;
import org.abn.userstorage.operation.Get;
import org.abn.userstorage.operation.GetUserId;
import org.abn.userstorage.operation.Set;

class UserStorageOperationFactory 
{
	private var appContext:UserStorage;
	
	public function new(appContext:UserStorage) 
	{
		this.appContext = appContext;
	}
	
	public function getOperationById(id:String):UserStorageOperation
	{
		var result:UserStorageOperation = null;
		var path:String = this.appContext.get("operations." + id + ".path");
		if (path == null)
			throw "can not find operation " + id;
		result = Type.createInstance(Type.resolveClass(path), [this.appContext]);
		return result;
	}
	
	public function getOperationParamsFromXML(node:Fast):Hash<String>
	{
		var result:Hash<String> = new Hash();
		for (pair in node.elements)
		{
			result.set(pair.name, pair.innerData);
		}
		return result;
	}
}