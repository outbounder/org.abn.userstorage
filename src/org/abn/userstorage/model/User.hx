package org.abn.userstorage.model;
import org.abn.neko.database.mysql.DataObject;


class User extends DataObject
{
	public var id:Int;
	public var userUID:String;
	public var username:String;
	public var password:String;
	
}