package ;

import flixel.addons.effects.FlxWaveSprite;
import FlxSpriteExt;
import flash.display.BlendMode;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTileblock;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxCamera;

class PlayState extends FlxState
{
	public static var ROOM:String;
	
	private var skipButton:FlxButton;
	private var background:FlxSprite;
	private var darkness:FlxSpriteExt;
	private var light:Light;
	private var player:Player;
	private var timer:FlxTimer;
	private var wall:FlxTileblock;
	private var keyPress:Bool;
	
	private var lampArray:Array<Dynamic> = [];
	private var wallArray:Array<Dynamic> = [];
	private var doorArray:Array<Dynamic> = [];
	private var eventArray:Array<Dynamic> = [];
	
	private var lampGroup:FlxGroup = new FlxGroup();
	private var wallGroup:FlxGroup = new FlxGroup();
	private var doorGroup:FlxGroup = new FlxGroup();
	private var eventGroup:FlxGroup = new FlxGroup();
	
	override public function create():Void
	{
		super.create();
		
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		
		var blank:FlxSprite = new FlxSprite(0, 0);
		blank.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		blank.scrollFactor.set(0, 0);
		add(blank);
		
		var intro:TextDark = new TextDark(['Foma:\n-"Urf"', 'Rocketko:\n-"Urf"', 'DrTwiSteD:\n-"Urf"', 'Urf:\n-"Huyurf"'], introComplete, 3);
		add(intro);
		
		skipButton = new FlxButton(0, 0, "Skip", function ()
		{
			intro.destroy();
			introComplete();
		} );
		skipButton.x = FlxG.width - (skipButton.width + 16);
		skipButton.y = FlxG.height - 32;
		add(skipButton);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
		
		FlxG.collide(player, wallGroup);
		FlxG.overlap(player, doorGroup, activeDoor);
		FlxG.overlap(player, eventGroup, activeEvent);
		
		keyPress = false;
		
		if (light != null)
		{
			light.x = player.x + (player.width / 2);
			light.y = player.y + (player.height / 2);
		}
		
		if (player != null)
		{
			for (i in 0...wallGroup.length)
			{
				if (wallGroup.members[i].active)
				{
					if (player.overlapsAt(player.x - 1, player.y, wallGroup.members[i]) || player.overlapsAt(player.x + 1, player.y, wallGroup.members[i]))
						player.wallTouching = true;
				}
			}
			
			if (player.x < -100)
				FlxG.switchState(new GameOver());
			
			if (player.x > FlxG.width + 100)
				FlxG.camera.fade(FlxColor.BLACK, .33, false, function() { FlxG.switchState(new MenuState()); } );
		}
	}
	
	override public function draw():Void
	{
		super.draw();
		
		if (darkness != null)
			darkness.fill(0xff000000);
	}
	
	private function introComplete():Void
	{
		skipButton.destroy();
		
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		
		init();
	}
	
	private function init():Void
	{
		FlxG.mouse.visible = false;
		FlxG.sound.playMusic(AssetPaths.bgmRoom__wav, 1, true);
		
		background = new FlxSprite(0, 0);
		background.y = 68;
		
		darkness = new FlxSpriteExt(0, 0);
		darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		darkness.scrollFactor.set(0, 0);
		darkness.blend = BlendMode.MULTIPLY;
		darkness.alpha = 0.985;
		
		light = new Light(darkness, 0, 0);
		
		player = new Player(5);
		
		// Room00
		lampArray.push(new Lamp(darkness, 153, "room00"));
		lampArray.push(new Lamp(darkness, 220, "room00"));
		doorArray.push(new Door(50, "room01", "room00", 125));
		eventArray.push(new Event(300, false, "assets/sounds/sfxChaseDone.wav", null, "room00"));
		// Room01
		wallArray.push(new Wall(25, 10, "room01"));
		wallArray.push(new Wall(285, 10, "room01"));
		lampArray.push(new Lamp(darkness, 135, "room01"));
		doorArray.push(new Door(120, "room00", "room01", 55));
		eventArray.push(new Event(220, true, "assets/sounds/sfxFadein.wav", "assets/images/doge.png", "room01"));
		
		setGroup(wallArray, wallGroup);
		setGroup(lampArray, lampGroup);
		setGroup(doorArray, doorGroup);
		setGroup(eventArray, eventGroup);
		
		setRoom("room00", 5);
		
		add(background);
		add(doorGroup);
		add(wallGroup);
		add(eventGroup);
		add(player);
		add(light);
		add(lampGroup);
		add(darkness);
		
		FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
	}
	
	private function setRoom(Room:String, Position:Int):Void
	{
		ROOM = Room;
		player.x = Position;
		
		setObjects(wallArray);
		setObjects(lampArray);
		setObjects(doorArray);
		setObjects(eventArray);
		
		switch (ROOM)
		{
			case "room00":
				FlxG.camera.setBounds(0, 0, 320, 240);
				background.loadGraphic(AssetPaths.room00__png);
			case "room01":
				FlxG.camera.setBounds(0, 0, 480, 240);
				background.loadGraphic(AssetPaths.room01__png);
		}
		
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
	}
	
	private function setObjects(array:Array<Dynamic>):Void
	{
		for (i in 0...array.length)
		{
			if (array[i].room == ROOM)
				array[i].enabled(true);
			else
				array[i].enabled(false);
		}
	}
	
	private function setGroup(array:Array<Dynamic>, group:FlxGroup):Void
	{
		for (i in 0...array.length)
		{
			group.add(array[i]);
		}
	}
	
	private function activeDoor(p:Player, d:Door):Void
	{
		if (p.overlaps(d) && !p.movingDisable && d.active)
		{
			if (FlxG.keys.anyJustPressed(["UP"]))
			{
				if (!keyPress)
					setRoom(d.location, d.position);
				
				keyPress = true;
			}
			
			d.setUse();
		}
		else
			d.setIdle();
	}
	
	private function activeEvent(p:Player, e:Event):Void
	{
		if (p.overlaps(e) && e.active)
		{
			if (e.picture != null)
			{
				var pic:FlxSprite = new FlxSprite(0, 0, e.picture);
				var timerStart:FlxTimer = new FlxTimer(0.3, function(e:FlxTimer) { add(pic); }, 1);
				var timerEnd:FlxTimer = new FlxTimer(0.4, function(e:FlxTimer) { pic.destroy(); }, 1);
				pic.x = (FlxG.width - pic.width) / 2;
				pic.y = (FlxG.height - pic.height) / 2;
				pic.scrollFactor.set(0, 0);
				pic.alpha = .5;
			}
			
			if (e.sound != null)
			{
				e.active = false;
				FlxG.sound.play(e.sound, 1, false, true, e.sfxComplete);
			}
		}
	}
}