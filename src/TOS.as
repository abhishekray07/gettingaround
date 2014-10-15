package
{
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	import flash.events.MouseEvent;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	
	public class TOS extends FlxState
	{
		
		[Embed(source = "../assets/Splash/TOS.jpg")]private var creditsPic:Class;
		
		private var credits:FlxSprite;
		protected var eventManager:EventManager;
		
		public function TOS()
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