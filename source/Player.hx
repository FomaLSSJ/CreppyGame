package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.system.FlxSound;

class Player extends FlxSprite
{
	private var walkSpeed:Int = 100;
	private var dragData:Int = 1000;
	
	public var movingDisable:Bool;
	public var wallTouching:Bool;
	public var blured:Bool;
	
	//private var sfxStep:FlxSound = new FlxSound();

	public function new(X:Float)
	{
		super(X, 95);
		loadGraphic(AssetPaths.player__png, true, 38, 60);
		
		animation.add("idle", [3], 20, false);
		animation.add("walk", [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 0], 20, true);
		
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		drag.x = dragData;
		
		setSize(19, 50);
		offset.set(8, 4);
		
		//sfxStep.loadEmbedded(AssetPaths.sfxStep__wav, true, false);
		
		animation.play("idle");
	}
	
	override public function destroy():Void
	{
		//sfxStep.destroy();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		controls();
		animate();
	}
	
	private function controls():Void
	{	
		if (!movingDisable)
		{
			if (FlxG.keys.anyPressed(["LEFT"]))
			{
				//sfxStep.play();
				facing = FlxObject.LEFT;
				velocity.x = -walkSpeed;
			}
			if (FlxG.keys.anyPressed(["RIGHT"]))
			{
				//sfxStep.play();
				facing = FlxObject.RIGHT;
				velocity.x = walkSpeed;
			}
		}
	}
	
	private function animate():Void
	{
		if (velocity.x == 0 || wallTouching)
			animation.play("idle");
		else
			animation.play("walk");
		
		wallTouching = false;
	}
}