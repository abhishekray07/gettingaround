package
{
	import flash.events.MouseEvent;
	
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class Credits extends FlxState
	{
		[Embed(source = "../assets/Splash/credits.jpg")]private var creditsPic:Class;
		
		private var credits:FlxSprite;
		protected var eventManager:EventManager;
		
		public function Credits()
		{
			super();
			
			this.eventManager = new EventManager();
			
			this.credits = new FlxSprite(0,0,creditsPic);
			EventManager.registerEvent(this.credits,MouseEvent.MOUSE_UP, onCredits);
		}
		
		override public function create():void{
			
			this.add(this.eventManager);
			this.add(this.credits);
		}
		
		private function onCredits(sprite:FlxObject, eventName:String):Boolean
		{
			FlxG.switchState(new MenuState);
			
			return true;
		}
		
	}
}