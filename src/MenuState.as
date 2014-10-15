package  
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.utils.Timer;
	
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		[Embed(source = "../assets/Splash/mainMenu.jpg")]private var menuPic:Class;
		
		[Embed(source = "../assets/Graphics/buttons/play.png")]private var playPic:Class;
		[Embed(source = "../assets/Graphics/buttons/play-roll.png")]private var playRollPic:Class;
		
		[Embed(source = "../assets/Graphics/buttons/instructions.png")]private var instructionsPic:Class;
		[Embed(source = "../assets/Graphics/buttons/instructions-roll.png")]private var instructionsRollPic:Class;
		
		[Embed(source = "../assets/Graphics/buttons/credits.png")]private var creditsPic:Class;
		[Embed(source = "../assets/Graphics/buttons/credits-roll.png")]private var creditsRollPic:Class;
		
		[Embed(source = "../assets/Graphics/buttons/invite.png")]private var invitePic:Class;
		[Embed(source = "../assets/Graphics/buttons/invite-roll.png")]private var inviteRollPic:Class;
		
		[Embed(source = "../assets/Graphics/buttons/about.png")]private var aboutPic:Class;
		[Embed(source = "../assets/Graphics/buttons/about-roll.png")]private var aboutRollPic:Class;
		
		[Embed(source = "../assets/Graphics/buttons/fb.png")]private var fbPic:Class;
		[Embed(source = "../assets/Graphics/buttons/fb-roll.png")]private var fbRollPic:Class;
		
		[Embed(source = "../assets/Graphics/buttons/btn_terms.png")]private var tosPic:Class;
		
		private var playButton:FlxSprite;
		private var playRollButton:FlxSprite;
		
		private var instructionsButton:FlxSprite;
		private var instructionsRollButton:FlxSprite;
		
		private var creditsButton:FlxSprite;
		private var creditsRollButton:FlxSprite;
		
		private var inviteButton:FlxSprite;
		private var inviteRollButton:FlxSprite;
		
		private var aboutButton:FlxSprite;
		private var aboutRollButton:FlxSprite;
		
		private var fbButton:FlxSprite;
		private var fbRollButton:FlxSprite;
		
		private var tosButton:FlxSprite;
		
		private var menuScreen:FlxSprite;
		
		private var facebook:FacebookWrapper;
		
		//declare the event manager and levels
		protected var eventManager:EventManager;
		
		public function MenuState()
		{
			this.eventManager = new EventManager();
			
			this.menuScreen = new FlxSprite(0,0, menuPic);
			
			this.playButton = new FlxSprite(575,264,playPic);
			this.playRollButton = new FlxSprite(575,264,playRollPic);
			this.playRollButton.visible = false;
			
			this.instructionsButton = new FlxSprite(694,212,instructionsPic);
			this.instructionsRollButton = new FlxSprite(694,212,instructionsRollPic);
			this.instructionsRollButton.visible = false;
			
			this.creditsButton = new FlxSprite(717,527,creditsPic);
			this.creditsRollButton = new FlxSprite(717,527,creditsRollPic);
			this.creditsRollButton.visible = false;
			
			this.tosButton = new FlxSprite(646,562,tosPic);
			
			this.inviteButton = new FlxSprite(596,371,invitePic);
			this.inviteRollButton = new FlxSprite(596,371,inviteRollPic);
			this.inviteRollButton.visible = false;
			
			this.aboutButton = new FlxSprite(609,421,aboutPic);
			this.aboutRollButton = new FlxSprite(609,421,aboutRollPic);
			this.aboutRollButton.visible = false;
			
			this.fbButton = new FlxSprite(737,418,fbPic);
			this.fbRollButton = new FlxSprite(737,418,fbRollPic);
			this.fbRollButton.visible = false;
			
			EventManager.registerEvent(this.playRollButton,MouseEvent.MOUSE_UP,startGame);
			EventManager.registerEvent(this.instructionsRollButton,MouseEvent.MOUSE_UP,instructions);
			EventManager.registerEvent(this.creditsRollButton,MouseEvent.MOUSE_UP,credits);
			EventManager.registerEvent(this.inviteRollButton,MouseEvent.MOUSE_UP,invite);
			EventManager.registerEvent(this.aboutRollButton,MouseEvent.MOUSE_UP,aboutNTU);
			EventManager.registerEvent(this.fbRollButton,MouseEvent.MOUSE_UP,fbPage);
			EventManager.registerEvent(this.tosButton,MouseEvent.MOUSE_UP,terms);
			
			this.facebook = new FacebookWrapper();
			
		}
		override public function create():void
		{
			FlxG.mouse.show();
			this.add(this.eventManager);
			this.add(this.menuScreen);
			this.add(this.playButton);
			this.add(this.playRollButton);
			this.add(this.instructionsButton);
			this.add(this.instructionsRollButton);
			this.add(this.creditsButton);
			this.add(this.creditsRollButton);
			this.add(this.inviteButton);
			this.add(this.inviteRollButton);
			this.add(this.aboutButton);
			this.add(this.aboutRollButton);
			this.add(this.fbButton);
			this.add(this.fbRollButton);
			this.add(this.tosButton);
		}
		
		override public function update():void
		{
			if(GameGlobals.mouseOverlaps(this.playButton))
			{
				this.playButton.visible = false;
				this.playRollButton.visible = true;
			}
			
			else
			{
				this.playButton.visible = true;
				this.playRollButton.visible = false;
			}
			
			if(GameGlobals.mouseOverlaps(this.instructionsButton))
			{
				this.instructionsButton.visible = false;
				this.instructionsRollButton.visible = true;
			}
				
			else
			{
				this.instructionsButton.visible = true;
				this.instructionsRollButton.visible = false;
			}
			
			if(GameGlobals.mouseOverlaps(this.creditsButton))
			{
				this.creditsButton.visible = false;
				this.creditsRollButton.visible = true;
			}
				
			else
			{
				this.creditsButton.visible = true;
				this.creditsRollButton.visible = false;
			}
			
			if(GameGlobals.mouseOverlaps(this.inviteButton))
			{
				this.inviteButton.visible = false;
				this.inviteRollButton.visible = true;
			}
				
			else
			{
				this.inviteButton.visible = true;
				this.inviteRollButton.visible = false;
			}
			
			if(GameGlobals.mouseOverlaps(this.aboutButton))
			{
				this.aboutButton.visible = false;
				this.aboutRollButton.visible = true;
			}
				
			else
			{
				this.aboutButton.visible = true;
				this.aboutRollButton.visible = false;
			}
			
			if(GameGlobals.mouseOverlaps(this.fbButton))
			{
				this.fbButton.visible = false;
				this.fbRollButton.visible = true;
			}
				
			else
			{
				this.fbButton.visible = true;
				this.fbRollButton.visible = false;
			}
		}
		
		private function startGame(sprite:FlxObject, eventName:String):Boolean
		{
			FlxG.mouse.hide();
			
//			this.facebook.onPublish();
			
			FlxG.switchState(new PlayState);
			
			return true;
		}
		
		private function instructions(sprite:FlxObject, eventName:String):Boolean
		{
			FlxG.switchState(new Instructions);
			
			return true;
		}
		
		private function credits(sprite:FlxObject, eventName:String):Boolean
		{
			FlxG.switchState(new Credits);
			return true;
		}
		
		private function terms(sprite:FlxObject, eventName:String):Boolean
		{
			FlxG.switchState(new TOS);
			return true;
		}
		
		private function invite(sprite:FlxObject, eventName:String):Boolean
		{
			this.facebook.onFriends();	
			return false;
		}
		
		private function aboutNTU(sprite:FlxObject, eventName:String):Boolean
		{
			FlxG.switchState(new AboutNTU);
			return true;
		}
		
		private function fbPage(sprite:FlxObject, eventName:String):Boolean
		{
			var isReady:Boolean = ExternalInterface.call("showFBPage");
				
			return false;
		}
		
		
	}

}