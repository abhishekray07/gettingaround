package
{
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class WinScreen extends FlxState
	{
		[Embed(source = "../assets/Splash/winScreen.jpg")]private var gameFinishPic:Class;
		
		private var gameFinish:FlxSprite;
		private var replay:FlxSprite;
		private var foodGame:FlxSprite;
		protected var eventManager:EventManager;
		
		public function WinScreen()
		{
			super();
			
			this.eventManager = new EventManager();
			this.gameFinish = new FlxSprite(0,0, gameFinishPic);
			
			this.replay = new FlxSprite(646, 462);
			this.replay.width = 130;
			this.replay.height = 53;
			this.replay.visible = false;
			
			EventManager.registerEvent(this.replay, MouseEvent.MOUSE_UP,onGameFinish);
			
			this.foodGame = new FlxSprite(535, 526);
			this.foodGame.width = 243;
			this.foodGame.height = 30;
			this.foodGame.visible = false;
			
			EventManager.registerEvent(this.foodGame, MouseEvent.MOUSE_UP,onFoodGame);
			
//			PlayState.musicPlayer.loadEmbedded(PlayState.applauseMusic,false);
//			FlxG.play(PlayState.applauseMusic,1,false);
		}
		
		override public function create():void
		{
			this.add(this.eventManager);
			this.add(this.gameFinish);
			this.add(this.replay);
			this.add(this.foodGame);
		}
		
		private function onGameFinish(screenSprite:FlxObject, eventName:String):Boolean
		{
			PlayState.musicPlayer.stop();
			
			ExternalInterface.call("fb_publish_win()");
			
			FlxG.switchState(new MenuState);
			return true;
		}
		
		private function onFoodGame(screenSprite:FlxObject, eventName:String):Boolean
		{
			PlayState.musicPlayer.stop();
			
			ExternalInterface.call("goFoodGame()");
			
			FlxG.switchState(new MenuState);
			return true;
		}
	}
}