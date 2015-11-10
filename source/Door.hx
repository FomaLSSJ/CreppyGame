package ;

import flixel.FlxObject;
import flixel.FlxSprite;

class Door extends FlxSprite
{
	static private var DOOR_IDLE:Dynamic = AssetPaths.door_idle__png;
	static private var DOOR_USE:Dynamic = AssetPaths.door_use__png;
	
	public var room:String;
	public var location:String;
	public var position:Int;
	
	public function new(X:Float, Room:String, Location:String, Position:Int):Void
	{
		super(X, 82, DOOR_IDLE);
		
		location = Location;
		room = Room;
		position = Position;
	}
	
	public function setIdle():Void
	{
		loadGraphic(DOOR_IDLE);
	}
	
	public function setUse():Void
	{
		loadGraphic(DOOR_USE);
	}
	
	public function enabled(val:Bool):Void
	{
		active = visible = val;
	}
}