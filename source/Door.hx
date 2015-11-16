package ;

import flixel.FlxObject;
import flixel.FlxSprite;

class Door extends FlxSprite
{
	static private var DOOR_IDLE:Dynamic = AssetPaths.door_idle__png;
	static private var DOOR_USE:Dynamic = AssetPaths.door_use__png;
	static private var DOOR_CLOSE_IDLE:Dynamic = AssetPaths.door_close_idle__png;
	static private var DOOR_CLOSE_USE:Dynamic = AssetPaths.door_close_use__png;

	public var room:String;
	public var location:String;
	public var position:Int;
	public var closed:Bool;
	public var key:Int;

	public function new(X:Float, Room:String, Location:String, Position:Int, Closed:Bool = false, Key:Int = 0):Void
	{
		super(X, 82);
		
		this.location = Location;
		this.room = Room;
		this.position = Position;
		this.closed = Closed;
		this.key = Key;
		
		if (this.closed)
		{
			this.loadGraphic(DOOR_CLOSE_IDLE);
		}
		else
		{
			this.loadGraphic(DOOR_IDLE);
		}
	}

	public function open():Void
	{
		this.closed = false;
	}

	public function setIdle():Void
	{
		if (this.closed)
		{
			this.loadGraphic(DOOR_CLOSE_IDLE);
		}
		else
		{
			this.loadGraphic(DOOR_IDLE);
		}
	}

	public function setUse():Void
	{
		if (this.closed)
		{
			this.loadGraphic(DOOR_CLOSE_USE);
		}
		else
		{
			this.loadGraphic(DOOR_USE);
		}
	}

	public function enabled(Val:Bool):Void
	{
		this.active = this.visible = Val;
	}
}