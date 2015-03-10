package ;

import flash.display.BlendMode;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxTimer;
import flixel.util.FlxRandom;

class Lamp extends FlxSprite
{
	private var darkness:FlxSprite;
	
	public var room:String;
	
	public function new(Darkness:FlxSprite, X:Float = 0, Room:String):Void
	{
		super(X, 100, AssetPaths.lamp_light_x2__png);
		
		darkness = Darkness;
		room = Room;
		
		blend = BlendMode.SCREEN;
		
		var timerOff:FlxTimer = new FlxTimer(FlxRandom.intRanged(1, 3), onTimerOff, 1);
	}
	
	override public function draw():Void
	{
		var screenXY:FlxPoint = getScreenXY();
		
		darkness.stamp(this, Std.int(screenXY.x - this.width / 2), Std.int(screenXY.y - this.height / 2));
	}
	
	private function onTimerOff(e:FlxTimer):Void
	{
		var timerOn:FlxTimer = new FlxTimer(0.3, onTimerOn, 1);
		this.alpha = FlxRandom.intRanged(3, 7) * 0.1;
	}
	
	private function onTimerOn(Timer:FlxTimer):Void
	{
		var timerOff:FlxTimer = new FlxTimer(FlxRandom.intRanged(1, 3), onTimerOff, 1);
		this.alpha = 1;
	}
	
	public function enabled(val:Bool):Void
	{
		active = visible = val;
	}
}