package org.abn.userstorage;

import haxe.Stack;
import haxe.xml.Fast;
import neko.io.File;
import neko.Lib;
import neko.Web;
import org.abn.Context;
import org.abn.ContextParser;
import org.abn.neko.AppContext;
import org.abn.uberTora.ClientRequestContext;
import org.abn.uberTora.UberToraContext;

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
		Lib.print(service.executeOperation(Web.getURI().substr(1), Web.getParams()));
	}
	
	public static function handleRequests(request:Dynamic):Void
	{
		var requestContext:ClientRequestContext = UberToraContext.getAsClientRequestContext(request);
		trace("incoming request");
		try
		{
			requestContext.sendResponse(service.executeOperation(requestContext.getURI().substr(1),requestContext.getParams()));
		}
		catch (e:Dynamic)
		{
			requestContext.sendResponse(e);
			trace(Stack.toString(Stack.exceptionStack()));
		}
	}
	
}