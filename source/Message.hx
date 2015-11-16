package;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.group.FlxTypedGroup;

class Message extends FlxTypedGroup<Dynamic>
{
	private var background:FlxSprite;
	private var message:FlxText;
	private var timer:FlxTimer;
	private var pos_x:Float;
	private var pos_y:Float;
	
	public function new():Void
	{
		super();
		
		this.background = new FlxSprite(0, 0);
		this.background.makeGraphic(64, 14, FlxColor.BLACK);
		this.background.alpha = 0.5;
		add(this.background);
		
		this.message = new FlxText(0, 0, 64, "");
		add(this.message);
		
		this.background.y = this.message.y = 80;
		
		this.visible = false;
	}

	override public function update():Void
	{
		this.background.x = this.message.x = this.pos_x - this.background.width / 2;
	}

	private function timerComplite(e:FlxTimer):Void
	{
		this.visible = false;
	}

	public function popup(Text:String, Time:Float = 1.5):Void
	{
		this.message.text = Text;
		this.timer = new FlxTimer(Time, timerComplite);
		
		this.visible = true;
	}

	public function pos(X:Float = 0, Y:Float = 0):Void
	{
		this.pos_x = X;
		this.pos_y = Y;
	}
}