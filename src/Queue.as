package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Abhishek
	 */
	public class Queue 
	{
		public var queueSprite:FlxSprite;
		private var _hotspots:Array;
		private var _characters:Array;
		
		public function get hotspots () : Array
		{
			return _hotspots;
		}
		
		public function get characters () : Array
		{
			return _characters;
		}
		
		private var _bus:String;
		
		public function get bus () : String
		{
			return _bus;
		}
		
		public function Queue(x:Number, y:Number, 
		width:Number, height:Number, hotspots:Array, bus:String) 
		{
			this.queueSprite = new FlxSprite(x, y);
			this.queueSprite.width = width;
			this.queueSprite.height = height;
			
			this._characters = new Array();
			this._hotspots = hotspots;
			this._bus = bus;
		}
		
	}

}