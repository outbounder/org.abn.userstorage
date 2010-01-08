/**
 * ...
 * @author outbounder
 */

package org.abn.userstorage.model;
import haxe.rtti.Infos;
import org.abn.neko.database.mysql.DataObject;

class Pair extends DataObject, implements Infos
{
	public var id:Int;
	public var key:String;
	public var value:String;
	public var userId:String;
	public var sourceId:String;
}