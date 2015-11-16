package;

import flixel.FlxSprite;

class Item extends FlxSprite
{
	public var id:Int;
	public var name:String;
	public var image:Dynamic;
	public var room:String;

	public function new(Id:Int, Name:String, Image:Dynamic, Room:String = "", X:Float=0, Y:Float=0):Void
	{
		super(X, Y);
		
		this.id = Id;
		this.name = Name;
		this.image = Image;
		this.room = Room;
		
		this.loadGraphic(this.image);
	}

	public function enabled(Val:Bool):Void
	{
		this.active = this.visible = Val;
	}
}