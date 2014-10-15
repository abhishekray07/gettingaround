package
{
	import flash.events.MouseEvent;
	
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class Instructions extends FlxState
	{
		[Embed(source = "../assets/Splash/instructions.jpg")]private var instructionsPic:Class;
		
		private var instructions:FlxSprite;
		protected var eventManager:EventManager;
		
		public function Instructions()
		{
			super();
			
			this.eventManager = new EventManager();
			
			this.instructions = new FlxSprite(0,0,instructionsPic);
			EventManager.registerEvent(this.instructions,MouseEvent.MOUSE_UP, onInstructions);
		}
		
		override public function create():void{
			
			this.add(this.eventManager);
			this.add(this.instructions);
		}
		
		private function onInstructions(sprite:FlxObject, eventName:String):Boolean
		{
			FlxG.switchState(new MenuState);
			
			return true;
		}
		
	}
}