package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Sprite extends FlxSprite
{
	public var room:String;

	public function new(X:Float=0, Y:Float=0, SimpleGraphic:FlxGraphicAsset, Room:String):Void
	{
		super(X, Y, SimpleGraphic);
		
		room = Room;
	}
	
	public function enabled(val:Bool):Void
	{
		active = visible = val;
	}
}