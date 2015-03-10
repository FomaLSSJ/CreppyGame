package ;

import flixel.FlxSprite;

class FlxSpriteExt extends FlxSprite
{
	public function new(X:Float = 0, Y:Float = 0, ?SimpleGraphic:Dynamic):Void
	{
		super(X, Y, SimpleGraphic);
	}
	
	/**
	 * Fills this sprite's graphic with a specific color.
	 * @param	Color The color with which to fill the graphic, format 0xAARRGGBB.
	 */
	#if flash
	public function fill(Color:UInt):Void
	#else
	public function fill(Color:BitmapInt32):Void
	#end
	{
		pixels.fillRect(_flashRect2, Color);
		if (pixels != framePixels)
		{
			dirty = true;
		}
		
		#if (cpp || neko)
		_calculatedPixelsIndex = -1;
		#end
		
		updateFrameData();
	}
}