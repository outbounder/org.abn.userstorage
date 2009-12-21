package org.abn.userstorage;

import haxe.Stack;
import haxe.xml.Fast;
import neko.io.File;
import neko.Lib;
import neko.Web;
import org.abn.Context;
import org.abn.ContextParser;
import org.abn.neko.AppContext;

class Main 
{
	private static var service:UserStorage;
	
	public static function main() 
	{
		var parser:ContextParser = new ContextParser();
		var xml:Xml = Xml.parse(File.getContent(Web.getCwd() + "assets/config.xml"));
		var fast:Fast = new Fast(xml.firstElement());
		var context:Context = parser.getContext(fast);

		service = new UserStorage(new AppContext(context.getProperties()));
		handleRequests();
	}
	
	public static function handleRequests():Void
	{
		try
		{
			Lib.print(service.executeOperation(Web.getURI().substr(1),Web.getParams()));
		}
		catch (e:Dynamic)
		{
			Lib.println(e);
			trace(Stack.toString(Stack.exceptionStack()));
		}
	}
	
}