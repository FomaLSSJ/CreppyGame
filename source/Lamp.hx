package ;

import flash.display.BlendMode;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.math.FlxRandom;

class Lamp extends FlxSprite
{
	private var darkness:FlxSprite;
	private var random:FlxRandom = new FlxRandom();
	
	public var room:String;
	
	public function new(Darkness:FlxSprite, X:Float = 0, Room:String):Void
	{
		super(X, 100, AssetPaths.lamp_light_x2__png);
		
		darkness = Darkness;
		room = Room;
		
		blend = BlendMode.SCREEN;
		
		onTimerOn(null);
	}
	
	override public function draw():Void
	{
		var screenXY:FlxPoint = getScreenPosition();
		
		darkness.stamp(this, Std.int(screenXY.x - this.width / 2), Std.int(screenXY.y - this.height / 2));
	}
	
	private function onTimerOff(e:FlxTimer):Void
	{
		var timerOn:FlxTimer = new FlxTimer().start(0.3, onTimerOn, 1);
		this.alpha = random.int(3, 7) * 0.1;
	}
	
	private function onTimerOn(Timer:FlxTimer):Void
	{
		var timerOff:FlxTimer = new FlxTimer().start(random.int(1, 3), onTimerOff, 1);
		this.alpha = 1;
	}
	
	public function enabled(val:Bool):Void
	{
		active = visible = val;
	}
}