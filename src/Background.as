package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Abhishek
	 */
	public class Background extends FlxGroup
	{
		private var backgroundLayers:Array;
		public function Background(backgroundLayers:Array) 
		{
			super();
			this.backgroundLayers = backgroundLayers;
			
			var i:int;
			for (i =  this.backgroundLayers.length - 1; i >= 0; i--)
			{
				this.add(new FlxSprite(0, 0, backgroundLayers[i]));
			}
		}
		
	}

}