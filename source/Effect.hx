package;

import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxTimer;
import openfl.filters.BlurFilter;

class Effect extends FlxObject
{
	private var blurFilter:BlurFilter;
	private var value:Float;
	private var quality:Int;
	
	private var timerStart:FlxTimer;
	private var timerWait:FlxTimer;
	private var timerEnd:FlxTimer;
	
	public function new():Void
	{
		super();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (blurFilter != null && timerStart != null)
		{
			blurFilter.blurX = blurFilter.blurY = timerStart.elapsedTime * 2;
		}
		
		if (blurFilter != null && timerEnd != null)
		{
			blurFilter.blurX = blurFilter.blurY = timerEnd.timeLeft * 2;
		}
	}
	
	override public function draw():Void
	{
		if (blurFilter != null)
		{
			FlxG.camera.buffer.applyFilter(FlxG.camera.buffer, FlxG.camera.buffer.rect, new Point(0, 0), blurFilter);
		}
	}
	
	private function blurStart(t:FlxTimer):Void
	{
		Reg.player.blured = true;
		timerWait = new FlxTimer().start(value, blurWait);
		timerStart.destroy();
		timerStart = null;
	}
	
	private function blurWait(t:FlxTimer):Void
	{
		timerEnd = new FlxTimer().start(value / 2, blurEnd);
		timerWait.destroy();
		timerWait = null;
	}
	
	private function blurEnd(t:FlxTimer):Void
	{
		Reg.player.blured = false;
		trace('false');
		timerEnd.destroy();
		timerEnd = null;
		blurFilter = null;
	}
	
	private function blurOnlyStart(t:FlxTimer):Void
	{
		timerStart.destroy();
		timerStart = null;
	}
	
	/**
	 * Blur effect.
	 * 
	 * @param value Value blured
	 * @param quality Quality blured
	 * @param method Set method (0-Time, 1-Start, 2-End)
	 */
	public function blur(value:Float, quality:Int, method:Int = 0):Void
	{
		this.value = value;
		this.quality = quality;
		
		blurFilter = new BlurFilter();
		blurFilter.quality = quality;
		
		switch (method) 
		{
			case 0:
				if (timerStart == null)
				{
					Reg.player.blured = true;
					trace('true');
					timerStart = new FlxTimer().start(value / 2, blurStart);
				}
			case 1:
				if (timerStart == null)
				{
					Reg.player.blured = true;
					trace('true');
					timerStart = new FlxTimer().start(value / 2, blurOnlyStart);
				}
			case 2:
				if (timerEnd == null)
				{
					timerEnd = new FlxTimer().start(value / 2, blurEnd);
				}
		}
	}
}