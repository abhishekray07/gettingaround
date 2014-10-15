package
{
	import flash.events.MouseEvent;
	
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class Introduction extends FlxState
	{
		[Embed(source = "../assets/Splash/intro.jpg")]private var introPic:Class;
		
		private var intro:FlxSprite;
		protected var eventManager:EventManager;
		
		public function Introduction()
		{
			super();
			
			this.eventManager = new EventManager();
			this.intro = new FlxSprite(0,0,introPic);
			EventManager.registerEvent(this.intro,MouseEvent.MOUSE_UP, onIntro);
		}
		
		override public function create():void{
			
			this.add(this.eventManager);
			this.add(this.intro);
		}
		
		private function onIntro(sprite:FlxObject, eventName:String):Boolean
		{
			FlxG.switchState(new MenuState);
			
			return true;
		}
		
	}
}