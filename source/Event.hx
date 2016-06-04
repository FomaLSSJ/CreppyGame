package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Event extends FlxSprite
{
	public var sound:String;
	public var picture:String;
	public var repeat:Bool;
	public var room:String;
	public var currentRoom:String;
	public var callback:Void->Void = null;
	
	public function new(X:Float, Repeat:Bool, Sound:String, Picture:String, Room:String, ?Callback:Void->Void):Void
	{
		super(X, 0);
		
		repeat = Repeat;
		sound = Sound;
		picture = Picture;
		room = Room;
		callback = Callback;
		
		makeGraphic(8, FlxG.height, FlxColor.GREEN);
		alpha = 0;
	}
	
	override public function destroy():Void
	{
		super.destroy();
		
		FlxG.sound.destroy();
	}
	
	public function sfxComplete():Void
	{
		if (!repeat)
			destroy();
		
		if (room == PlayState.ROOM)
			active = repeat;
		else
			active = false;
	}
	
	public function callCallback():Void //TODO Refactoring function name
	{
		callback();
	}
	
	public function enabled(val:Bool):Void
	{
		active = visible = val;
	}
}