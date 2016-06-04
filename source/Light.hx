package ;

import flash.display.BlendMode;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Light extends FlxSprite
{	
	private var darkness:FlxSprite;
	
	public function new(darkness:FlxSprite, X:Float = 0, Y:Float = 0):Void
	{
		super(X, Y, AssetPaths.glow_light_x3__png);
		
		this.darkness = darkness;
		this.blend = BlendMode.SCREEN;
	}
	
	override public function draw():Void
	{
		var screenXY:FlxPoint = getScreenPosition();
		
		darkness.stamp(this, Std.int(screenXY.x - this.width / 2), Std.int(screenXY.y - this.height / 2));
	}
}