/**
 * ...
 * @author outbounder
 */

package org.abn.userstorage.model;

import neko.db.ResultSet;
import Type;

class PairManager extends neko.db.Manager<Pair> 
{
    public function new() 
	{
        super(Pair);
    }
	
	public function updateTable():Void
	{
		var query:String = "SHOW TABLES LIKE '" + this.table_name + "'";
		var result:ResultSet = execute(query);
		if (result.length == 0)
			this.createTable();
		else
			this.alterTable();
	}
	
	private function createTable():Void
	{
		var s = new StringBuf();
		var fields = new List();
		var values = new List();
		var proto : { local_manager : PairManager } = this.class_proto.prototype;
		var protoFields: Array<String> = Reflect.fields(proto);
		for ( f in this.table_fields ) 
		{
			for ( v in protoFields)
			{
				if ( v == f ) 
				{
					if (f == "id")
						fields.add(this.quoteField(f) + " INT NOT NULL AUTO_INCREMENT");
					else
						fields.add(this.quoteField(f)+ " "+this.getMysqlFieldType(v));
				}
			}
		}
		s.add("CREATE TABLE `");
		s.add(this.table_name);
		s.add("` (");
		s.add(fields.join(","));
		s.add(", PRIMARY KEY (`id`)) ENGINE = MYISAM CHARACTER SET utf8 COLLATE utf8_general_ci");
		execute(s.toString());
	}
	
	private function alterTable():Void
	{
		var currentTableColumns:List<String> = this.getTableColumns();
		
		var s = new StringBuf();
		var fields = new List(); 
		var values = new List();
		var x:Pair = new Pair();
		for ( f in this.table_fields ) 
		{
			if (f == "id")
				continue;
			var found:Bool = false;
			for(tf in currentTableColumns)
			{
				if (tf == f)
					found = true;
			}
			if (found)
				fields.add("MODIFY COLUMN "+this.quoteField(f)+" "+this.getMysqlFieldType(f)+" NULL");
			else
				fields.add("ADD COLUMN "+this.quoteField(f)+" "+this.getMysqlFieldType(f)+" NULL");
		}
		
		s.add("ALTER TABLE `");
		s.add(this.table_name);
		s.add("` ");
		s.add(fields.join(","));
		
		execute(s.toString());
	}
	
	private function getMysqlFieldType(f:String):String
	{
		var proto : { local_manager : PairManager } = this.class_proto.prototype;
		var valType:ValueType = Type.typeof(Reflect.field(proto, f)); // TODO check this out, it returns always TNull, which will break the logic
		switch(valType)
		{
			case ValueType.TInt: return "INT";
			case ValueType.TFloat: return "FLOAT";
			case ValueType.TBool: return "BOOL";
			default: return "TEXT";
		}
	}
	
	private function getTableColumns():List<String>
	{
		var query = "SHOW COLUMNS FROM "+this.table_name;
		var resultSet:ResultSet = execute(query);
		var result:List<String> = new List();
		for(row in resultSet)
		{
			result.push(row.Field);
		}
		return result;
	}
	
	public function queryStartWith(key:String,userID:String):List<Pair>
	{
		var userIDMatch:String = userID == null?"":" AND " + this.quoteField("userId") + " = " + this.quote(userID);
		return objects(select(this.quoteField("key")+" LIKE " + this.quote(key + "%")+userIDMatch), true);
	}
}