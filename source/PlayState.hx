package ;

import flash.geom.Point;
import flash.display.BlendMode;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTileblock;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxCamera;

class PlayState extends FlxState
{
	public static var ROOM:String;
	
	private var skipButton:FlxButton;
	private var background:FlxSprite;
	private var darkness:FlxSprite;
	private var inventory:Inventory;
	private var player:Player;
	private var light:Light;
	private var message:Message;
	private var timer:FlxTimer;
	private var wall:FlxTileblock;
	private var keyPress:Bool;
	private var effect:Effect;
	
	private var roomArray:Array<Dynamic> = [];
	private var lampArray:Array<Dynamic> = [];
	private var wallArray:Array<Dynamic> = [];
	private var doorArray:Array<Dynamic> = [];
	private var eventArray:Array<Dynamic> = [];
	private var itemArray:Array<Dynamic> = [];
	private var spriteArray:Array<Dynamic> = [];
	
	private var roomGroup:FlxGroup = new FlxGroup();
	private var lampGroup:FlxGroup = new FlxGroup();
	private var wallGroup:FlxGroup = new FlxGroup();
	private var doorGroup:FlxGroup = new FlxGroup();
	private var eventGroup:FlxGroup = new FlxGroup();
	private var itemGroup:FlxGroup = new FlxGroup();
	private var spriteGroup:FlxGroup = new FlxGroup();
	
	override public function create():Void
	{
		super.create();
		
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		
		var blank:FlxSprite = new FlxSprite(0, 0);
		blank.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		blank.scrollFactor.set(0, 0);
		add(blank);
		
		var intro:TextDark = new TextDark([
			'Foma:\n-"Urf"',
			'Rocketko:\n-"Urf"',
			'DrTwiSteD:\n-"Urf"',
			'Urf:\n-"Huyurf"'
		], introComplete, 3);
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

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		FlxG.collide(Reg.player, wallGroup);
		FlxG.overlap(Reg.player, doorGroup, activeDoor);
		FlxG.overlap(Reg.player, eventGroup, activeEvent);
		FlxG.overlap(Reg.player, itemGroup, activeItem);
		FlxG.overlap(Reg.player, spriteGroup, activeSprite);
		
		keyPress = false;
		
		if (Reg.player != null)
		{
			for (i in 0...wallGroup.length)
			{
				if (wallGroup.members[i].active)
				{
					if (Reg.player.overlapsAt(Reg.player.x - 1, Reg.player.y, wallGroup.members[i]) || Reg.player.overlapsAt(Reg.player.x + 1, Reg.player.y, wallGroup.members[i]))
						Reg.player.wallTouching = true;
				}
			}
			
			if (Reg.player.x < -100)
				onDirections("left", roomArray);
			
			if (Reg.player.x > FlxG.width + 100)
				onDirections("right", roomArray);
		}
		
		if (light != null)
		{
			light.x = Reg.player.x + (Reg.player.width / 2);
			light.y = Reg.player.y + (Reg.player.height / 2);
		}
		
		if (Reg.player != null && inventory != null && message != null)
		{
			if (!keyPress && !Reg.player.movingDisable)
			{
				if (FlxG.keys.anyJustPressed(["i", "I", "TAB"]))
				{
					message.popup("I have " + inventory.getItemsName());
				}
			}
		}
	}
	
	override public function draw():Void
	{
		super.draw();
		
		if (darkness != null)
			FlxSpriteUtil.fill(darkness, 0xff000000);
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
		
		darkness = new FlxSprite(0, 0);
		darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		darkness.scrollFactor.set(0, 0);
		darkness.blend = BlendMode.MULTIPLY;
		darkness.alpha = 0.985;
		
		inventory = new Inventory();
		//inventory.addItem(new Item(1, "Key", null));
		
		Reg.player = new Player(5);
		
		light = new Light(darkness, 0, 0);
		
		message = new Message();
		effect = new Effect();
		
		// Room00
		roomArray.push(new Room("room00", AssetPaths.room00__png, [0, 0, 320, 240], function()
		{
			FlxG.switchState(new GameOver());
		}, function()
		{
			setRoom("room03", 0);
		}));
		lampArray.push(new Lamp(darkness, 153, "room00"));
		lampArray.push(new Lamp(darkness, 220, "room00"));
		doorArray.push(new Door(50, "room00", "room01", 125));
		doorArray.push(new Door(125, "room00", "room02", 125, true, 1));
		eventArray.push(new Event(300, false, "assets/sounds/sfxChaseDone.wav", null, "room00"));
		spriteArray.push(new Sprite(130, 90, AssetPaths.fog_smoke__png, "room00"));
		spriteArray.push(new Sprite(180, 90, AssetPaths.fog_smoke__png, "room00"));
		// Room01
		roomArray.push(new Room("room01", AssetPaths.room01__png, [0, 0, 480, 240]));
		wallArray.push(new Wall(25, 10, "room01"));
		wallArray.push(new Wall(285, 10, "room01"));
		lampArray.push(new Lamp(darkness, 135, "room01"));
		doorArray.push(new Door(120, "room01", "room00", 55));
		eventArray.push(new Event(220, true, "assets/sounds/sfxFadein.wav", "assets/images/doge.png", "room01"));
		// Room02
		roomArray.push(new Room("room02", AssetPaths.room01__png, [0, 0, 320, 240]));
		wallArray.push(new Wall(25, 10, "room02"));
		wallArray.push(new Wall(285, 10, "room02"));
		lampArray.push(new Lamp(darkness, 205, "room02"));
		doorArray.push(new Door(120, "room02", "room00", 125));
		itemArray.push(new Item(2, "Rusty Key", AssetPaths.shine__png, "room02", 120, 125));
		// Room03
		roomArray.push(new Room("room03", AssetPaths.room00__png, [0, 0, 320, 240], function()
		{
			setRoom("room00", 310);
		}, function()
		{
			FlxG.camera.fade(FlxColor.BLACK, .33, false, function() { FlxG.switchState(new MenuState()); } );
		}));
		lampArray.push(new Lamp(darkness, 55, "room03"));
		eventArray.push(new Event(230, true, "assets/sounds/sfxChaseDone.wav", null, "room03"));
		itemArray.push(new Item(1, "Key", AssetPaths.shine__png, "room03", 120, 125));
		
		setGroup(roomArray, roomGroup);
		setGroup(wallArray, wallGroup);
		setGroup(lampArray, lampGroup);
		setGroup(doorArray, doorGroup);
		setGroup(eventArray, eventGroup);
		setGroup(itemArray, itemGroup);
		setGroup(spriteArray, spriteGroup);
		
		add(roomGroup);
		add(doorGroup);
		add(wallGroup);
		add(eventGroup);
		add(itemGroup);
		add(spriteGroup);
		add(Reg.player);
		add(light);
		add(lampGroup);
		add(darkness);
		add(effect);
		add(message);
		
		setRoom("room00", 5);
		
		FlxG.camera.follow(Reg.player, FlxCameraFollowStyle.PLATFORMER);
	}
	
	private function onDirections(dir:String, array:Array<Dynamic>)
	{
		for (i in 0...array.length)
		{
			if (array[i].room == ROOM)
			{
				if (dir == "left") {
					array[i].callLeft();
				}
				else
				{
					array[i].callRight();
				}
			}
		}
	}
	
	private function setRoom(Room:String, Position:Int):Void
	{
		ROOM = Room;
		Reg.player.x = Position;
		
		setObjects(roomArray);
		setObjects(wallArray);
		setObjects(lampArray);
		setObjects(doorArray);
		setObjects(eventArray);
		setObjects(itemArray);
		setObjects(spriteArray);
		
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
	}
	
	private function setObjects(array:Array<Dynamic>):Void
	{
		for (i in 0...array.length)
		{
			if (array[i].room == ROOM)
			{
				array[i].enabled(true);
				
				if (Std.is(array[i], Room)) {
					FlxG.camera.setScrollBoundsRect(array[i].bounds[0], array[i].bounds[1], array[i].bounds[2], array[i].bounds[3]);
				}
			}
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

	private function activeItem(p:Player, i:Item):Void
	{
		if (p.overlaps(i) && !p.movingDisable && i.active)
		{
			if (FlxG.keys.anyJustPressed(["DOWN"]))
			{
				if (!keyPress)
				{
					message.popup("I found the " + i.name);
					inventory.addItem(i);
					i.destroy();
				}
			}
		}
	}

	private function activeDoor(p:Player, d:Door):Void
	{
		if (p.overlaps(d) && !p.movingDisable && d.active)
		{
			if (FlxG.keys.anyJustPressed(["UP"]))
			{
				if (!keyPress)
					if (d.closed)
					{
						if (inventory.getItem(d.key))
						{
							message.popup("Open");
							d.open();
						}
						else
						{
							message.popup("Closed");
						}
					}
					else
					{
						setRoom(d.location, d.position);
					}
				
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
				var timerStart:FlxTimer = new FlxTimer().start(0.3, function(e:FlxTimer) { add(pic); }, 1);
				var timerEnd:FlxTimer = new FlxTimer().start(0.4, function(e:FlxTimer) { pic.destroy(); }, 1);
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
			
			if (e.callback != null)
			{
				e.callCallback();
			}
		}
	}
	
	private function activeSprite(p:Player, s:Sprite):Void
	{
		// TODO need optimize effect
		/*
		if (p.overlaps(s) && s.active)
		{
			if (!p.blured)
			{
				effect.blur(3, 3, 1);
			}
		}
		else
		{
			if (p.blured)
			{
				effect.blur(3, 3, 2);
			}
		}
		*/
	}
}