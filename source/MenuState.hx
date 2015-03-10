package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	override public function create():Void
	{
		super.create();
		
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		FlxG.mouse.visible = true;
		
		var verNum:FlxText = new FlxText(0, 0, 0, "ver. 0.8.4");
		verNum.x = FlxG.width - (verNum.width + 8);
		verNum.y = 8;
		
		var titleText:FlxText = new FlxText(0, 0, 0, "- Suspense -", 32);
		titleText.x = (FlxG.width - titleText.width) / 2;
		titleText.y = (FlxG.height - titleText.height) / 2 - 32;
		titleText.setFormat(null, 32, FlxColor.BLACK);
		titleText.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.WHITE, 1);
		
		var hintText:FlxText = new FlxText(0, 0, 0, "Wow. Such harror, much survivar!");
		hintText.x = (FlxG.width - hintText.width) / 2;
		hintText.y = (FlxG.height - hintText.height) / 2;
		
		var playButton:FlxButton = new FlxButton(0, 0, "New Game", onPlay);
		playButton.x = (FlxG.width - playButton.width) / 2;
		playButton.y = FlxG.height - 32;
		
		add(verNum);
		add(titleText);
		add(hintText);
		add(playButton);
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
	}
	
	private function onPlay():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function() { FlxG.switchState(new PlayState()); });
	}
}