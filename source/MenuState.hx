package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	override public function create():Void
	{
		super.create();
		
		var data:Localized = new Localized();
		Reg.localized = data.get().US;
		
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		FlxG.mouse.visible = true;
		
		var verNum:FlxText = new FlxText(0, 0, 0, "ver. 0.9.2");
		verNum.x = FlxG.width - (verNum.width + 8);
		verNum.y = 8;
		
		var titleText:FlxText = new FlxText(0, 0, 0, Reg.localized.DATA.MENU.TITLE, 32);
		titleText.x = (FlxG.width - titleText.width) / 2;
		titleText.y = (FlxG.height - titleText.height) / 2 - 32;
		titleText.setFormat(null, 32, FlxColor.BLACK);
		titleText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.WHITE, 1);
		
		var hintText:FlxText = new FlxText(0, 0, 0, Reg.localized.DATA.MENU.DESCRIPTION);
		hintText.x = (FlxG.width - hintText.width) / 2;
		hintText.y = (FlxG.height - hintText.height) / 2;
		
		var playButton:FlxButton = new FlxButton(0, 0, Reg.localized.DATA.MENU.NEW_GAME, onPlay);
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

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function onPlay():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function() { FlxG.switchState(new PlayState()); });
	}
}