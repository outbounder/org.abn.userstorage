/**
 * ...
 * @author outbounder
 */

package org.abn.userstorage.model;
import haxe.rtti.Infos;
import neko.db.Object;

class Pair extends Object, implements Infos
{
	public var id:Int;
	public var key:String;
	public var value:String;
	public var userId:String;
	public var sourceId:String;
	
	public static var manager = new PairManager();
}