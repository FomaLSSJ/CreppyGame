package;

import flixel.FlxSprite;
import flixel.FlxG;

class Room extends FlxSprite
{
	private var room:String;
	private var background:String;
	private var bounds:Array<Int>;
	private var onleft:Void->Void = null;
	private var onright:Void->Void = null;
	
	public function new(Room:String, Background:String, Bounds:Array<Int>, ?onLeft:Void->Void, ?onRight:Void->Void, X:Float = 0, Y:Float = 0)
	{
		super(X, 68, Background);
		
		this.room = Room;
		this.background = Background;
		this.bounds = Bounds;
		this.onleft = onLeft;
		this.onright = onRight;
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	public function callLeft():Void
	{
		this.onleft();
	}
	
	public function callRight():Void
	{
		this.onright();
	}
	
	public function enabled(val:Bool):Void
	{
		active = visible = val;
	}
}