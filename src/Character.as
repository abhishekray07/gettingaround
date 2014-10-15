package  
{
	/**
	 * ...
	 * @author Abhishek
	 */
	
	import flash.utils.Dictionary;
	
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class Character extends FlxSprite
	{
		[Embed(source = "../assets/Characters/char-malayGuy.png")]private var characterMalayBoyPic:Class;
		[Embed(source = "../assets/Characters/char-malayGirl.png")]private var characterMalayGirlPic:Class;
		
		[Embed(source = "../assets/Characters/char-ChineseBoy.png")]private var characterChineseBoyPic:Class;
		[Embed(source = "../assets/Characters/char-ChineseGirl.png")]private var characterChineseGirlPic:Class;
		
		[Embed(source = "../assets/Characters/char-indianGirl.png")]private var characteIndianGirlPic:Class;
		[Embed(source = "../assets/Characters/char-indianGuy.png")]private var characterIndianGuyPic:Class;
		
		[Embed(source = "../assets/Characters/char-angmoGirl.png")]private var characterangmoGirlPic:Class;
		[Embed(source = "../assets/Characters/char-angmoBoy.png")]private var characterangmoGuyPic:Class;
		
		[Embed(source = "../assets/Characters/char-uniqGuy01.png")]private var characterUnique1Pic:Class;
		[Embed(source = "../assets/Characters/char-uniqGuy02.png")]private var characterUnique2Pic:Class;
		[Embed(source = "../assets/Characters/char-uniqGuy03.png")]private var characterUnique3Pic:Class;
		
		[Embed(source = "../assets/Characters/spriteTest-02.png")]private var characterNormalPic:Class;
		
		[Embed(source = "../assets/Graphics/totBubble.png")]private var totBubble:Class;
		[Embed(source = "../assets/Graphics/totBubbleMedium.png")]private var totBubbleMedium:Class;
		[Embed(source = "../assets/Graphics/totBubbleLarge.png")]private var totBubbleLarge:Class;
		[Embed(source = "../assets/Graphics/totBubblePhoto.png")]private var totBubblePic:Class;
		
		[Embed(source="/../assets/Fonts/GILLSANS.TTF", fontFamily="GLS", embedAsCFF="false")] 
		private var FontGLS:String;
		
		private var _bus:String;
		
		private var _buses:Array;
		
		private var _liveTime:Number;
		
		private var _live:Boolean;

		public function get bubbleTextBoxMedium():FlxSprite
		{
			return _bubbleTextBoxMedium;
		}

		public function set bubbleTextBoxMedium(value:FlxSprite):void
		{
			_bubbleTextBoxMedium = value;
		}

		public function get live():Boolean
		{
			return _live;
		}

		public function set live(value:Boolean):void
		{
			_live = value;
		}

		public function get liveTime():Number
		{
			return _liveTime;
		}

		public function set liveTime(value:Number):void
		{
			_liveTime = value;
		}

		public function get buses():Array
		{
			return _buses;
		}

		public function set buses(value:Array):void
		{
			_buses = value;
		}

		public function get bubbleBoxPic():FlxSprite
		{
			return _bubbleBoxPic;
		}

		public function set bubbleBoxPic(value:FlxSprite):void
		{
			_bubbleBoxPic = value;
		}

		public function get bubbleTextBoxPic():FlxSprite
		{
			return _bubbleTextBoxPic;
		}

		public function set bubbleTextBoxPic(value:FlxSprite):void
		{
			_bubbleTextBoxPic = value;
		}

		public function get bubbleTextLarge():FlxText
		{
			return _bubbleTextLarge;
		}

		public function set bubbleTextLarge(value:FlxText):void
		{
			_bubbleTextLarge = value;
		}

		public function get bubbleTextBoxLarge():FlxSprite
		{
			return _bubbleTextBoxLarge;
		}

		public function set bubbleTextBoxLarge(value:FlxSprite):void
		{
			_bubbleTextBoxLarge = value;
		}

		public function get bus () : String
		{
			return _bus;
		}
		
		private var _original:FlxPoint;
		public function get original () : FlxPoint
		{
			return _original;
		}
		
		//Hover Text
		protected var _bubbleText:FlxText;
		
		//hover text textbox
		protected var _bubbleTextBox:FlxSprite;
		
		private var _bubbleTextBoxLarge:FlxSprite;
		
		private var _bubbleTextBoxPic:FlxSprite;
		
		private var _bubbleTextBoxMedium:FlxSprite;
		
		private var _bubbleBoxPic:FlxSprite;
		
		private var _bubbleTextLarge:FlxText;
		
		public function get bubbleText():FlxText{return _bubbleText;}
		
		public function get bubbleTextBox():FlxSprite{return _bubbleTextBox;}
		
		public function Character(bus:String,x:Number, y:Number, charChoice:int, levelName:int) 
		{
			super(x, y - 150);
			
			trace("Char Choice " +  charChoice);
			switch(charChoice)
			{
				case 1:
					loadGraphic(characteIndianGirlPic,true,true,80,140);
					break;
				
				case 2:
					loadGraphic(characterangmoGirlPic,true,true,80,140);
					break;
				
				case 3:
					loadGraphic(characterangmoGuyPic,true,true,80,140);
					break;
			
				case 4:
					loadGraphic(characterChineseBoyPic,true,true,80,140);
					break;
				
				case 5:
					loadGraphic(characterChineseGirlPic,true,true,80,140);
					break;
				
				case 6:
					loadGraphic(characterIndianGuyPic,true,true,80,140);
					break;
				
				case 7:
					loadGraphic(characterMalayBoyPic,true,true,80,140);
					break;
				
				case 8:
					loadGraphic(characterMalayGirlPic,true,true,80,140);
					break;
				
				case 9:
					loadGraphic(characterNormalPic,true,true,80,140);
					break;
				
				case 10:
					loadGraphic(characterUnique1Pic,true,true,80,140);
					break;
				
				case 11:
					loadGraphic(characterUnique2Pic,true,true,80,140);
					break;
				
				case 12:
					loadGraphic(characterUnique3Pic,true,true,80,140);
					break;
			}
			
			this.liveTime = 5;
			
			this.live = true;
			
			this._original = new FlxPoint(x, y - 150);
			
			if(levelName == 1)
			{
				this._bus = bus;
				
				_bubbleText = new FlxText(0,0,97,"");
				_bubbleText.setFormat("GLS", 14, 0x00000000, "center",0xffFFF00F);
				_bubbleText.text = this.bus;
				
				_bubbleTextBox = new FlxSprite(0,0,totBubble);
			}
			
			else
			{
			//	trace("Adding a character with large tot bubble");
				var loc:Locations = generateCharacterLocation(levelName);
				
				if(levelName == 2)
				{
					var randNum:int = Math.random()*12;
					
					if(randNum < 6)
					{
						var busIndex:int = Math.random() * loc.buses.length;
						var busLev2:String = loc.buses[busIndex];
						
						if(busLev2 == "C" && loc.name == "H8-11")
							busLev2 = loc.buses[Math.random()*(loc.buses.length - 1)] ;
					
						this._bus = busLev2;
					}
					
					else if(randNum == 6 || randNum == 7)
					{
						loc = PlayState.NIE;
						this._bus = "199";
					}
					
					else if(randNum == 8)
					{
						loc = PlayState.GRADHALL;
						this._bus = "199";
					}
					
					else if(randNum == 9 || randNum == 10)
					{
						loc = PlayState.NIE;
						this._bus = "B";
					}
						
					else
					{
						loc = PlayState.GRADHALL;
						this._bus = "B";
					}
					
					_bubbleText = new FlxText(0,0,94,"");
					_bubbleText.setFormat("GLS", 14, 0x00000000, "center", 0xffFFF00F);
					_bubbleText.text = loc.name;
					
					_bubbleTextLarge = new FlxText(0,0,60,"");
					_bubbleTextLarge.setFormat("GLS", 14, 0x00000000, "center", 0xffFFF00F);
					_bubbleTextLarge.text = this.bus;
					
					_bubbleTextBoxMedium = new FlxSprite(0,0,totBubbleMedium);
				}
				
				else if(levelName == 3)
				{
					this.buses = loc.buses;
					
					_bubbleText = new FlxText(0,0,97,"");
					_bubbleText.setFormat("GLS", 14, 0x00000000, "center",0xffFFF00F);
					_bubbleText.text = loc.name;
					
					_bubbleTextBox = new FlxSprite(0,0,totBubble);
				}
				
				else if( levelName == 4)
				{
					this.buses = loc.buses;
					
					_bubbleText = new FlxText(0,0,97,"");
					_bubbleText.setFormat("GLS", 14, 0x00000000, "center",0xffFFF00F);
					_bubbleText.text = loc.name;
					
					_bubbleTextBoxLarge = new FlxSprite(0,0,totBubbleLarge);
					_bubbleBoxPic = new FlxSprite(0,0, PlayState.iconDict[loc.name]);
				}
				
				else if(levelName == 5)
				{
					this._buses = loc.buses;
					
					_bubbleText = new FlxText(0,0,2,"");
					
					_bubbleTextBoxPic = new FlxSprite(0,0,totBubblePic);
					_bubbleBoxPic = new FlxSprite(0,0, PlayState.iconDict[loc.name]);	
				}
			}
			
			
			if(_bubbleTextBox != null)
				_bubbleTextBox.visible = true;
			
			else if(_bubbleTextBoxMedium != null)
			{
				_bubbleTextBoxMedium.visible = true;
			}
			
			else if(_bubbleTextBoxLarge != null)
			{
				_bubbleTextBoxLarge.visible = true;
				
				if(_bubbleBoxPic != null)
					_bubbleBoxPic.visible = true;	
			}
			
			else
			{
				_bubbleTextBoxPic.visible = true;
				_bubbleBoxPic.visible = true;
			}
			
	//		_bubbleTextBox.makeGraphic(1, 1,0xaaffffff,true);
			
			this.addAnimation("idle",[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],16,false);
			
		}
		
		override public function update():void
		{
			this.play("idle");
			
			if(this.liveTime > 0)
			{
				this.liveTime -= FlxG.elapsed;
			}
			
			else
			{
			//	trace("Character is dead");
				this.live = false;
			}
			
			if(this.bubbleText.visible)
			{
				if(this.bubbleTextBox != null)
				{
					this.bubbleText.x = this.x;
					this.bubbleText.y = this.y - 28;
					
					this.createBubbleBox();
					
					this.bubbleText.visible = true;
					this.bubbleTextBox.visible = true;
				}
				
				else if ( this.bubbleTextBoxMedium != null)
				{
					this.bubbleText.x = this.x - 18;
					this.bubbleText.y = this.y - 24;
					
					this.bubbleTextLarge.x = this.x + 45;
					this.bubbleTextLarge.y = this.y - 30;
					
					this.createBubbleBoxMedium();
					
					this.bubbleText.visible = true;
					
					this.bubbleTextLarge.visible = true;
						
					this.bubbleTextBoxMedium.visible = true;
				}
				
				
				else if ( this.bubbleTextBoxLarge != null)
				{
						this.bubbleText.x = this.x - 18;
						this.bubbleText.y = this.y - 15;
						
						if(this.bubbleTextLarge != null)
						{
							this.bubbleTextLarge.x = this.x + 45;
							this.bubbleTextLarge.y = this.y - 18;
						}
						
						else
						{
							this.bubbleBoxPic.x = this.x + 50;
							this.bubbleBoxPic.y = this.y - 47;	
						}
						
						this.createBubbleBoxLarge();
						
						this.bubbleText.visible = true;
						
						if(this.bubbleTextLarge != null)
							this.bubbleTextLarge.visible = true;
						
						else
							this.bubbleBoxPic.visible = true;
						
						this.bubbleTextBoxLarge.visible = true;
				}
				
				else
				{
					this.bubbleText.x = 0; //this.x - 10;
					this.bubbleText.y = 0; //this.y - 38;
					
					
					this.createBubbleBoxPic();
					
					this.bubbleText.visible = true;
					this.bubbleTextBoxPic.visible = true;
					this.bubbleBoxPic.visible = true;
				}
			}
		}
		
		private function createBubbleBox():void
		{
			this.bubbleTextBox.x = this.x;//+ this.bubbleText.width/2;
			this.bubbleTextBox.y = this.y - 45;// + this.bubbleText.height/2;
		}
		
		private function createBubbleBoxLarge():void
		{
			this.bubbleTextBoxLarge.x = this.x;//+ this.bubbleText.width/2;
			this.bubbleTextBoxLarge.y = this.y - 50;// + this.bubbleText.height/2;
		}
		
		private function createBubbleBoxMedium():void
		{
			this.bubbleTextBoxMedium.x = this.x;//+ this.bubbleText.width/2;
			this.bubbleTextBoxMedium.y = this.y - 44;// + this.bubbleText.height/2;
		}
		
		private function createBubbleBoxPic():void
		{
			this.bubbleTextBoxPic.x = this.x;//+ this.bubbleText.width/2;
			this.bubbleTextBoxPic.y = this.y - 60;// + this.bubbleText.height/2;
			
			this.bubbleBoxPic.x = this.x + 2;
			this.bubbleBoxPic.y = this.y - 57;
		}
		
		private function generateCharacterLocation(levelName:int):Locations
		{
			var correctLocation:Boolean = true;
			var locIndex:int;
			var loc:Locations;
			
			do{
				correctLocation = true;
				
				locIndex = Math.random()*PlayState.locations.length;
				loc = PlayState.locations[locIndex];
				//trace("Location Name generated " + loc.name);
				
				if(loc.name == "ADM" && levelName == 2)
				{
					//trace("Getting stuck here");
					correctLocation = false;
				}
				else if(loc.name == "INNO" && levelName == 3)
					correctLocation = false;
				
				else if(loc.name == "LWN" && levelName == 4)
					correctLocation = false;
				
				else if(loc.name == "NIE" && levelName == 5)
					correctLocation = false;
				
				else if(loc.name == "NIE" && levelName == 3)
					correctLocation = false;
				
				else if(loc.name == "SBS" && levelName == 5)
					correctLocation = false;
				
				else if(loc.name == "MRT" && loc.buses[0] == "179" && ( levelName == 2 || levelName== 3 || levelName == 5))
					correctLocation = false;
				
				else if(loc.name == "MRT" && loc.buses[0] == "X" && ( levelName == 1 || levelName== 2 || levelName == 4 || levelName == 5))
					correctLocation = false;
				
				else if(loc.name == "MRT" && loc.buses[0] == "199" && ( levelName == 3 || levelName == 4))
					correctLocation = false;
				
			}while(!correctLocation);
			
			return loc;
		}
	}

}