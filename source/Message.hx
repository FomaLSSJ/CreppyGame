package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;

class Message extends FlxTypedGroup<Dynamic>
{
	private var message:FlxText;
	private var timer:FlxTimer;
	private var pos_x:Float;
	private var pos_y:Float;
	
	public function new():Void
	{
		super();
		
		this.message = new FlxText(64, FlxG.height - 32, FlxG.width - 128, "");
		this.message.alpha = 0.8;
		add(this.message);
		
		this.visible = false;
	}

	private function timerComplite(e:FlxTimer):Void
	{
		this.visible = false;
		this.timer = null;
	}

	public function popup(Text:String, Time:Float = 4.0):Void
	{
		var lines:Int = Std.int(Text.length / 10) + 1;
		
		this.message.text = Text;
		this.timer = new FlxTimer().start(Time, timerComplite);
		this.visible = true;
	}
}