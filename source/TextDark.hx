package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.FlxDestroyUtil;

class TextDark extends FlxTypedGroup<FlxSprite>
{
	private var callback:Void->Void = null;
	private var background:FlxSprite;
	private var messages:Array<String>;
	private var message:FlxText;
	private var timer:FlxTimer;
	private var time:Int;
	private var index:Int;

	public function new(messages:Array<String>, ?callback:Void->Void, time:Int = 2):Void
	{
		super();
		
		this.callback = callback;
		this.messages = messages;
		this.time = time;
		
		background = new FlxSprite(0, 0);
		background.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(background);
		
		message = new FlxText(10, 10, 300, "");
		add(message);
		
		setText();
	}
	
	override public function destroy():Void
	{
		callback = null;
		messages = null;
		background = FlxDestroyUtil.destroy(background);
		message = FlxDestroyUtil.destroy(message);
		timer = FlxDestroyUtil.destroy(timer);
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void
	{
		if (index + 1 > messages.length)
			callback();
	}
	
	private function setText():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, false);
		timer = new FlxTimer().start(this.time, timerComplete);
		
		message.text = messages[index];
	}
	
	private function timerComplete(e:FlxTimer):Void
	{
		if (index + 1 < messages.length)
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, true);
			timer = null;
			index++;
			
			setText();
		}
		else
		{
			callback();
			destroy();
		}
	}
}