package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.system.input.Mouse;

	
	public class GameGlobals
	{
		protected static var instance:GameGlobals=new GameGlobals();
		
		protected function destroy():void
		{
			
		}
		
		public static function mouseOverlaps(obj:FlxObject,useEntireCursor:Boolean=false,pixelPerfectCollision:Boolean=false):Boolean
		{
			if (useEntireCursor)
			{
				if (pixelPerfectCollision)
				{
					var pt:FlxPoint=new FlxPoint(FlxG.mouse.x ,FlxG.mouse.y);
					if (obj is FlxSprite)
						return (obj as FlxSprite).pixelsOverlapPoint(pt);
					return obj.overlapsPoint(pt);
				}
				else	
					return true;// currentCursor.overlapsAt(FlxG.mouse.x, FlxG.mouse.y, obj, true);
			}
			else
			{
				var pt:FlxPoint=new FlxPoint(FlxG.mouse.x ,FlxG.mouse.y);
				return obj.overlapsPoint(pt);
			}
		}
	}
}
