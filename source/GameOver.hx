package ;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class GameOver extends FlxState
{
	//no variables

	override public function create():Void
	{
		FlxG.mouse.visible = true;
		FlxG.sound.music.stop();
		FlxG.sound.play(AssetPaths.sfxAlerted__wav);
		
		var titleText:FlxText = new FlxText(0, 0, 0, "- Game Over -", 32);
		titleText.x = (FlxG.width - titleText.width) / 2;
		titleText.y = (FlxG.height - titleText.height) / 2 - 32;
		titleText.setFormat(null, 32, FlxColor.BLACK);
		titleText.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.WHITE, 1);
		
		var hintText:FlxText = new FlxText(0, 0, 0, "You fucking pussy!");
		hintText.x = (FlxG.width - hintText.width) / 2;
		hintText.y = (FlxG.height - hintText.height) / 2;
		
		var restartButton:FlxButton = new FlxButton(0, 0, "Restart", onRestart);
		restartButton.x = (FlxG.width - restartButton.width) / 2;
		restartButton.y = FlxG.height - 32;
		
		add(titleText);
		add(hintText);
		add(restartButton);
	}
	
	private function onRestart():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function() { FlxG.switchState(new MenuState()); });
	}
}