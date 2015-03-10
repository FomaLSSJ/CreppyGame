package ;

import flixel.FlxG;
import flixel.tile.FlxTileblock;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.FlxObject;

class Wall extends FlxTileblock
{	
	public var room:String;
	
	public function new(X:Int, Width:Int, Room:String):Void
	{
		super(X, 0, Width, FlxG.height);
		
		room = Room;
		alpha = .5;
	}
	
	public function enabled(val:Bool):Void
	{
		active = visible = solid = val;
	}
}