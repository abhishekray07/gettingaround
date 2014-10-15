package
{
	
	import flash.events.MouseEvent;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.system.FlxAnim;
	
	public class Level extends FlxGroup
	{
		[Embed(source = "../assets/Graphics/minus5.png")]private var minus:Class;
		[Embed(source = "../assets/Graphics/plus10.png")]private var plus:Class;
		
		[Embed(source = "../assets/Graphics/scoreboard.png")]private var scoreBoardPic:Class;
		[Embed(source = "../assets/Graphics/timerBoard.png")]private var timerBoardPic:Class;
		
		[Embed(source = "../assets/Graphics/busGuide.png")]private var busGuideButtonPic:Class;
		[Embed(source = "../assets/Splash/busGuide.jpg")]private var busGuidePic:Class;
		
		[Embed(source = "../assets/Graphics/mainMenu.png")]private var mainMenuPic:Class;
		
		//Fonts
		[Embed(source="/../assets/Fonts/GILLSANS.TTF", fontFamily="NES", embedAsCFF="false")] 
		public static var FontNES:String;
		
		[Embed(source="/../assets/Fonts/Courier.TTF", fontFamily="CRR", embedAsCFF="false")] 
		public static var FontCRR:String;
		
		[Embed(source = "../assets/Splash/beforeStage.png")]private var beforeStagePic:Class;
		
		
		//list of buses for the level
		private var _busList:Array = new Array();
		
		//list of characters for the level
		private var _charactersList:Array = new Array();
		
		//list of queues for the level
		private var _queueList:Array = new Array();
		
		//Check if level is finished
		private var _levelFinished:Boolean = false;
		
		//global time for each level
		private var _globalTime:Number = 0;
		
		//count
		private var count:Number = 0;
		
		//Number of points required the clear the level
		private var _pointsReq:Number;
		
		private var yIndex:Number = 10;
		
		private var resetTimer:Boolean = false;
		
		private var prevTime:int = 0;
		private var currentTime:int;
		
		private var scoreBoard:FlxSprite;
		private var timerBoard:FlxSprite;
		
		private var spawnTime:Number;
		
		private var spawnIndex:int = 0;
		
		private var name:int;
		
		public var smokeSpr:Smoke;
		
		
		
		public function get globalTime():Number
		{
			return _globalTime;
		}

		public function set globalTime(value:Number):void
		{
			_globalTime = value;
		}

		public function get points():Number
		{
			return _points;
		}

		public function set points(value:Number):void
		{
			_points = value;
		}

		public function get pointsReq():Number
		{
			return _pointsReq;
		}

		public function set pointsReq(value:Number):void
		{
			_pointsReq = value;
		}

		public function get levelFinished():Boolean
		{
			return _levelFinished;
		}

		public function set levelFinished(value:Boolean):void
		{
			_levelFinished = value;
		}

		public function get queueList():Array
		{
			return _queueList;
		}
		
		public function set queueList(value:Array):void
		{
			_queueList = value;
		}
		
		public function get charactersList():Array
		{
			return _charactersList;
		}
		
		public function set charactersList(value:Array):void
		{
			_charactersList = value;
		}
		
		public function get busList():Array
		{
			return _busList;
		}
		
		public function set busList(value:Array):void
		{
			_busList = value;
		}

		
		//sprites for the background
		private var location:FlxSprite;
		private var backgroundSprites:Background;
		
		public var minusSprite:FlxSprite;
		public var plusSprite:FlxSprite;
		
		public var mainMenu:FlxSprite;
		public var busGuideButton:FlxSprite;
		public var busGuide:FlxSprite;
		
		//character group
		private var characterGrp:FlxGroup;
		private var levelGrp:FlxGroup;
		
		//character which is selected currently
		private var selectedItem:Character;
		
		//Timer related info
		private var timerText:FlxText;
		private var timer:Number = 4;
		
		//Points scored
		private var pointsText:FlxText;
		private var _points:Number = 0;
		
		private var curBus:Bus;
		private var nextBus:Bus;
		private var index:Number = 0;
		
		private var buses:Array;
		
		private var beforeStage:FlxSprite;
		private var beforeStageText:FlxText;
		private var levelNameText:FlxText;
		
		//To initialise a level - 3 different sprites needed
		public function Level(locPic:Class, busShelterPic:Class, busGroundPic:Class, pointsReq:Number, globalTime:Number, spawnTime:Number, name:Number )
		{
			super();
			
			//initializing the background sprites - maintaining the correct order is important
			this.location = new FlxSprite(0,0,locPic);
			this.backgroundSprites = new Background(new Array(busShelterPic, busGroundPic));
			
			//initialise the character group
			this.characterGrp = new FlxGroup();
			this.levelGrp = new FlxGroup();
			
			this.scoreBoard = new FlxSprite(682,7,scoreBoardPic);
			this.timerBoard = new FlxSprite(540,7,timerBoardPic);
			
			this.mainMenu = new FlxSprite(14,7,mainMenuPic);
			
			this.busGuide = new FlxSprite(0,0, busGuidePic);
			this.busGuide.visible = false;
			
			this.busGuideButton = new FlxSprite(635,7,busGuideButtonPic);
			
			this.pointsText = new FlxText(688, 7, 100, "");
			this.pointsText.setFormat ("NES", 30, 0xFFFFFFFF, "center",0xffFFF00F );
			this.pointsText.text += this.points;
			
			this._pointsReq = pointsReq;
			
			this.globalTime = globalTime;
			this.timerText = new FlxText(530, 10, 100, "");
			this.timerText.setFormat ("CRR", 25, 0xFFFFFFFF, "center",0xffFFF00F );
			this.timerText.text = this.globalTime.toString().substring(0, 3);
			
			
			this.minusSprite = new FlxSprite(0,0,minus);
			this.minusSprite.visible = false;
			
			this.plusSprite = new FlxSprite(0,0,plus);
			this.plusSprite.visible = false;
			
			this.buses = new Array("199", "179", "A", "B", "C", "D");
			
			this.spawnTime = spawnTime;
			
			this.name = name;
			
			this.beforeStage = new FlxSprite(0,0,beforeStagePic);
			
			
			if(this.pointsReq >= 1000)
			{
				this.beforeStageText = new FlxText(359, 250, 200, this.pointsReq.toString());
				this.beforeStageText.setFormat ("NES", 60, 0xFFFFFF33, "left");
			}
			else
			{
				this.beforeStageText = new FlxText(380, 250, 200, this.pointsReq.toString());
				this.beforeStageText.setFormat ("NES", 60, 0xFFFFFF33, "left");
			}
			
			this.levelNameText = new FlxText(161, 180, 460, "");
			this.levelNameText.setFormat ("NES", 25, 0xFFFFFF33, "center");
			
			if(this.name == 1)
				this.levelNameText.text = "Student Services Centre Bus Stop";
			
			else if(this.name == 2)
				this.levelNameText.text = "Bus Stop Opposite School of Art, Design & Media";
			
			else if(this.name == 3)
				this.levelNameText.text = "Innovation Centre Bus Stop";
			
			else if(this.name == 4)
				this.levelNameText.text = "Lee Wee Nam Library Bus Stop";
			
			else if(this.name == 5)
				this.levelNameText.text = "National Institute of Education Bus Stop";
			
		//	this.smokeSpr = new Smoke(300,300);
			//this.smokeSpr.visible
		}
		
	
		public function create():void
		{
			//again the order in which objects are drawn is important
			this.levelGrp.add(this.location);
			
			for each(var b:Bus in this.busList)
				this.levelGrp.add(b);
				
			this.levelGrp.add(backgroundSprites);
			
			for each(var c:Character in this.charactersList)
			{
				this.characterGrp.add(c);
				EventManager.registerEvent(c,MouseEvent.MOUSE_UP, this.onCharacterMouseUp);
				EventManager.registerEvent(c,MouseEvent.MOUSE_DOWN, this.onCharacterMouseDown);
			}
			
			this.levelGrp.add(this.characterGrp);
			
			for each(var c:Character in this.charactersList)
			{
				if(c.bubbleTextBox != null)
					this.levelGrp.add(c.bubbleTextBox);
				
				else if(c.bubbleTextBoxMedium != null)
				{
					this.levelGrp.add(c.bubbleTextBoxMedium);
					
					this.levelGrp.add(c.bubbleTextLarge);
				}
				
				else if(c.bubbleTextBoxLarge != null)
				{
					this.levelGrp.add(c.bubbleTextBoxLarge);
					
					if(c.bubbleTextLarge != null)
						this.levelGrp.add(c.bubbleTextLarge);
					
					else
						this.levelGrp.add(c.bubbleBoxPic);
				}
					
				else
				{
					this.levelGrp.add(c.bubbleTextBoxPic);
					this.levelGrp.add(c.bubbleBoxPic);
				}
				this.levelGrp.add(c.bubbleText);				
			}
			
			
			this.levelGrp.add(this.scoreBoard);
			this.levelGrp.add(this.timerBoard);
			this.levelGrp.add(this.pointsText);
			this.levelGrp.add(this.timerText);
			
			this.minusSprite.visible = false;
			
			
			this.plusSprite.visible = false;
			
			
			if(this.busList.length == 1)
			{
				curBus = this.busList[0];
				nextBus = this.busList[0];
			}
			
			else
			{
				curBus = this.busList[index++];
				nextBus = this.busList[index++];
			}
			
			this.levelGrp.add(this.busGuideButton);
			
			EventManager.registerEvent(this.mainMenu,MouseEvent.MOUSE_UP, onMainMenu);
			
			this.levelGrp.add(this.mainMenu);
			
			
			EventManager.registerEvent(this.busGuideButton,MouseEvent.MOUSE_UP, onBusGuideButton);
			
			this.add(this.levelGrp);
			this.add(this.minusSprite);
			this.add(this.plusSprite);
			
			this.add(this.busGuide);
			
			
			EventManager.registerEvent(this.beforeStage,MouseEvent.MOUSE_UP, onBeforeStage,1);
			this.add(this.beforeStage);
			
			this.add(this.beforeStageText);
			
			this.add(this.levelNameText);
			
		//	this.add(this.smokeSpr);
		}
		
		override public function update():void
		{
		//	this.smoke.play("smoke", true);
			
			if(!this.beforeStage.visible)
			{
				if(this.selectedItem != null)
				{
					//trace("Selected Item " + this.selectedItem);
					this.selectedItem.x = FlxG.mouse.screenX - this.selectedItem.width / 2;
					this.selectedItem.y = FlxG.mouse.screenY - this.selectedItem.height / 2;
					
				}
				
				checkCharacterAlive();
				//this.smoke.visible = false;
				
				//this.smoke.visible = true;
				
				
				if(!this.busGuide.visible)
				{
					if(this.globalTime > 0 )
					{
						this.globalTime -= FlxG.elapsed;
						this.timerText.text = this.globalTime.toString().substring(0, 4);
						
						currentTime = this.globalTime
						//	trace("Current Time" + currentTime);
						
						if(currentTime % this.spawnTime == 0 && currentTime != prevTime)
						{
							this.generateCharacter(396, 358, 340, 120);
							
							prevTime = currentTime;
							trace("Adding a character");
						} 
					}
						
					else
					{
						levelFinished = true;
						this.plusSprite.visible = false;
						this.minusSprite.visible = false;
					}
					
					if (this.timer > 0)
					{
						this.timer -= FlxG.elapsed;
						//this.timerText.text = this.timer.toString().substring(0, 3);
					}
						
					else if(this.minusSprite.visible)
					{
						this.minusSprite.y -= 2;
						
						yIndex += 2;
						//	trace("yIndex is = ", yIndex);
						
						if(yIndex >= 60)
						{
							yIndex = 10;
							this.minusSprite.visible = false;
							
							if(this.resetTimer)
								this.timer = 2;
						}
					}
						
					else if(this.plusSprite.visible)
					{
						this.plusSprite.y -= 2;
						
						yIndex += 2;
						//	trace("yIndex is = ", yIndex);
						
						if(yIndex >= 60)
						{
							yIndex = 10;
							this.plusSprite.visible = false;
							//	trace("Value of count is " + count);
							
							
							if(this.resetTimer)
							{
								//			trace("Reset Timer");
								this.timer = 2;
							}
						}
					}
						
						
						
					else
					{
						//this.timerText.text = "0";
						
						if(curBus.status == 0)
						{	
							curBus.status = 1;
							curBus.update();
							//	trace("Bus" + curBus.name + "Status = 1");
						}
							
						else if(curBus.status == 1)
						{
							curBus.update();
						}
							
						else if(curBus.status == 3)
						{	
							curBus.status = 4;
							curBus.update();
							//	trace("Bus" + curBus.name + "Status = 4");
						}
							
						else if(curBus.status == 4)
						{
							curBus.update();
						}
							
						else if(curBus.status == 6 && nextBus.status == 0)
						{
							//	trace("Coming here to this");
							curBus = nextBus;
							curBus.status = 1;
							
							if(index < this.busList.length)
							{
								nextBus = this.busList[index++];
								nextBus.x = 1200;
								nextBus.status = 0;
							}
							else
							{
								index = 0;
								nextBus = this.busList[index++];
								nextBus.x = 1200;
								nextBus.status = 0;
							}
							//	trace("Cur Bus" + curBus.name + "status" + curBus.status);
							//	trace("Next Bus" + nextBus.name + "status" + nextBus.status);
						}
						
					}
					
					if(!this.plusSprite.visible && !this.minusSprite.visible) 
					{
						if (curBus.status == 2)
						{	
							checkQueues(curBus.name);
							
							var lengthQ:int;
							var checkQueue:Queue;
							
							for each(var q:Queue in this.queueList)
							{
								if(q.bus == curBus.name)
									checkQueue = q;
							}
							
							lengthQ = checkQueue.characters.length;
							
							if(lengthQ == 0)
							{
								curBus.status = 3;
								resetTimer = true;
								
								//	trace("Bus" + curBus.name + "Status = 3");
								//	trace("Check Queues");
							}
							//	trace("Bus" + curBus.name + "Status = 2 Queue Not Empty Yet");
						}
						
						
						if(curBus.status == 5)
						{
							this.timer = 2;
							curBus.status = 6;
							//	trace("Bus" + curBus.name + "Status = 6");
							//	trace("Next Bus" + nextBus.name + "Status = " + nextBus.status);
							
						}
					}
					this.characterGrp.sort("y", ASCENDING);
					
					this.characterGrp.update();
				}
			}
		}
		
		private function checkQueues(busName:String):void
		{
			var i:int;
			var checkQueue:Queue;
		
			for each(var q:Queue in this.queueList)
			{
				if(q.bus == busName)
					checkQueue = q;
			}
			
		//	trace("Queue Name " + checkQueue.bus); 
			if(checkQueue.characters.length >= 1)
			{
				for (i = 0; i < 1; i++)
				{
					if(checkQueue.characters[i].bus != null)
					{
						if (checkQueue.characters[i].bus == checkQueue.bus)
						{	this.points += 100;
							//	trace("Coming Here Points");
							this.pointsText.text = this.points.toString();;
							count++;
							
					//		FlxG.music.stop();
//							FlxG.play(PlayState.correctMusic,1,false);
							
							//	trace("Plus sprite visible");
							this.plusSprite.x = checkQueue.characters[i].x;
							this.plusSprite.y = checkQueue.characters[i].y - 10;
							this.plusSprite.visible = true;
						}	
						else
						{	
							this.points -= 50;
							this.pointsText.text = this.points.toString();;
							count++;
							
				//			FlxG.music.stop();
//							FlxG.play(PlayState.wrongMusic,1,false);
							
							this.minusSprite.x = checkQueue.characters[i].x;
							this.minusSprite.y = checkQueue.characters[i].y - 10;
							this.minusSprite.visible = true;
							
						}
					}
					
					else
					{
						var flag:Boolean = false;
						
						for( var p:int = 0; p < checkQueue.characters[i].buses.length; p++)
						{
							if(checkQueue.characters[i].buses[p] == checkQueue.bus)
							{
								flag = true;
								break;
							}
						}
						
						if(flag)
						{
							this.points += 100;
							//	trace("Coming Here Points");
							this.pointsText.text = this.points.toString();;
							count++;
							
						//	FlxG.music.stop();
//							FlxG.play(PlayState.correctMusic,1,false);
							
							//	trace("Plus sprite visible");
							this.plusSprite.x = checkQueue.characters[i].x;
							this.plusSprite.y = checkQueue.characters[i].y - 10;
							this.plusSprite.visible = true;	
						}
						
						else
						{
							this.points -= 50;
							this.pointsText.text = this.points.toString();;
							count++;
							
						//	FlxG.music.stop();
//							FlxG.play(PlayState.wrongMusic,1,false);
							
							this.minusSprite.x = checkQueue.characters[i].x;
							this.minusSprite.y = checkQueue.characters[i].y - 10;
							this.minusSprite.visible = true;
						}
						
						
					}
					checkQueue.characters[i].visible = false;
					checkQueue.characters[i].active = false;
					checkQueue.characters[i].kill();
					checkQueue.characters[i].bubbleText.visible = false;
					checkQueue.characters[i].bubbleText.kill();
					
					if(checkQueue.characters[i].bubbleTextBox != null)
					{
						checkQueue.characters[i].bubbleTextBox.visible = false;
						checkQueue.characters[i].bubbleTextBox.kill();
					}
					
					else if(checkQueue.characters[i].bubbleTextBoxMedium != null)
					{
						checkQueue.characters[i].bubbleTextBoxMedium.visible = false;
						checkQueue.characters[i].bubbleTextBoxMedium.kill();
						
						checkQueue.characters[i].bubbleTextLarge.visible = false;
						checkQueue.characters[i].bubbleTextLarge.kill();
					}
					
					else if(checkQueue.characters[i].bubbleTextBoxLarge != null)
					{
						checkQueue.characters[i].bubbleTextBoxLarge.visible = false;
						checkQueue.characters[i].bubbleTextBoxLarge.kill();
						
						if(checkQueue.characters[i].bubbleTextLarge != null)
						{
							checkQueue.characters[i].bubbleTextLarge.visible = false;
							checkQueue.characters[i].bubbleTextLarge.kill();
						}
						
						else
						{
							checkQueue.characters[i].bubbleBoxPic.visible = false;
							checkQueue.characters[i].bubbleBoxPic.kill();	
						}
					}
					
					else
					{
						checkQueue.characters[i].bubbleTextBoxPic.visible = false;
						checkQueue.characters[i].bubbleTextBoxPic.kill();
						
						checkQueue.characters[i].bubbleBoxPic.visible = false;
						checkQueue.characters[i].bubbleBoxPic.kill();
					}
					
					EventManager.removeEvent(checkQueue.characters[i],MouseEvent.MOUSE_DOWN);
					EventManager.removeEvent(checkQueue.characters[i],MouseEvent.MOUSE_UP);
				}
				
				checkQueue.characters.splice(0,1);
			}
			
		}
		
		public function onCharacterMouseUp(character:FlxObject, eventName:String):Boolean
		{
			if(character != this.selectedItem)
				return false;
			
			else
			{
				trace("Calling Mouse up for " + (character as Character).bus);
				this.selectedItem = null;
				var checkQueue:Queue = null;
				
				for each(var q:Queue in this.queueList)
				{
					if (q.queueSprite.overlaps(character))
					{
						checkQueue = q;
					}
				}
				
				if(checkQueue != null)
				{
					//	trace("Check Queue Name " + checkQueue.bus);
					if(checkQueue.characters.lastIndexOf(character) == -1)
					{
						checkQueue.characters.push(character);
						var index:int = checkQueue.characters.lastIndexOf(character);
						//	trace("Last index character " + index);
						//trace("Hotspots size" + checkQueue.hotspots.length);
						character.x = checkQueue.hotspots[index].x - character.width/2 - 10;
						character.y = checkQueue.hotspots[index].y - 100;
						
						for each(var tempQ:Queue in this.queueList)
						{
							if(tempQ.bus != checkQueue.bus && tempQ.characters.lastIndexOf(character) != -1)
							{
								var index:int = tempQ.characters.lastIndexOf(character);
								tempQ.characters.splice(index, 1);
								rearrangeQueue(tempQ.bus);
								//		trace("Removing from other Queue " + tempQ.bus);
							}
						}
						//	trace("adding a character");
					}
						
					else
					{
						var index:int = checkQueue.characters.lastIndexOf(character);
						character.x = checkQueue.hotspots[index].x - character.width/2 - 10;
						character.y = checkQueue.hotspots[index].y - 100;
						//	trace("already in the queue");
					}
				}
					
				else
				{
					for each(var q:Queue in this.queueList)
					{
						if(q.characters.lastIndexOf(character) != -1)
						{
							//	trace("Remving from the queue");
							checkQueue = q;
							character.x = (character as Character).original.x;
							character.y = (character as Character).original.y;
							var index:int = q.characters.lastIndexOf(character);
							q.characters.splice(index, 1);
							rearrangeQueue(q.bus);
						}
					}
				}
				
				
				if(checkQueue == null)
				{
					//	trace("Not in any queue - putting to original position");
					character.x = (character as Character).original.x;
					character.y = (character as Character).original.y;
				}
				
				
				return true;
			}
		}
		
		private function rearrangeQueue(busName:String):void
		{
			var checkQueue:Queue;
			
			for each(var q:Queue in this.queueList)
			{
				if(q.bus == busName)
					checkQueue = q;
			}
			
			var i:int;
			for (i = 0; i < checkQueue.characters.length; i++)
			{
				checkQueue.characters[i].x = checkQueue.hotspots[i].x - checkQueue.characters[i].width/2 - 10;
				checkQueue.characters[i].y = checkQueue.hotspots[i].y - 100;
			}
		}
		
		public function onCharacterMouseDown(character:FlxObject, eventName:String):Boolean
		{
		//	trace("Calling Mouse Down");
			trace("Calling Mouse Down for " + (character as Character).bus);
			this.selectedItem = (character as Character);
			
			return false;
		}
		
		public function generateCharacter(topX:Number, topY:Number, width:Number, height:Number, random:Boolean = true, dest:String = null):void{
			
			var character:Character;
			
			var destination:String;
			
			if(dest != null)
			{
				destination = dest;
			}
			
			else
			{
				var index:int = Math.random()*this.buses.length;
				destination = this.buses[index];
			}
			
			
			var overlaps:Boolean = false;
			var xCoord:Number 
			var yCoord:Number
			
			
			var charIndex:int;
			charIndex = Math.random()*12 + 1;
			
			xCoord = PlayState.spawnPoints[spawnIndex].x;
			yCoord = PlayState.spawnPoints[spawnIndex].y;
			
			spawnIndex = (spawnIndex + 3 ) % PlayState.spawnPoints.length;
				
			if(this.name == 1)
			{
				var num:int = Math.random()*10;
				
				if(num % 2 == 0)
					character = new Character("D", xCoord, yCoord, charIndex, this.name);
				
				else
					character = new Character(destination, xCoord, yCoord, charIndex, this.name);
			}
			
			else
				character = new Character(destination, xCoord, yCoord, charIndex, this.name);
			
			this.charactersList.push(character);
			
			if(random == true)
			{
				EventManager.registerEvent(character,MouseEvent.MOUSE_UP, this.onCharacterMouseUp);
				EventManager.registerEvent(character,MouseEvent.MOUSE_DOWN, this.onCharacterMouseDown);
				
				this.characterGrp.add(character);
				
				if(character.bubbleTextBox != null)
					this.levelGrp.add(character.bubbleTextBox);
				
				else if(character.bubbleTextBoxMedium != null)
				{
					this.levelGrp.add(character.bubbleTextBoxMedium);
					this.levelGrp.add(character.bubbleTextLarge);
				}
				
				else if(character.bubbleTextBoxLarge != null)
				{
					this.levelGrp.add(character.bubbleTextBoxLarge);
					
					if(character.bubbleTextLarge != null)
						this.levelGrp.add(character.bubbleTextLarge);
						
					else
						this.levelGrp.add(character.bubbleBoxPic);
				}
				
				else
				{
					this.levelGrp.add(character.bubbleTextBoxPic);
					this.levelGrp.add(character.bubbleBoxPic);
				}
				this.levelGrp.add(character.bubbleText);
				
			}
			
			
			//prevTime = currentTime;
			//trace("Adding a character");
		}
		
		private function characterOverlaps(xCoord:Number, yCoord:Number):Boolean{
			
			//var char:Character = new Character("179", xCoord, yCoord);
			var point:FlxPoint = new FlxPoint(xCoord, yCoord);
			var point2:FlxPoint = new FlxPoint(xCoord + 80, yCoord);
			var point3:FlxPoint = new FlxPoint(xCoord, yCoord + 100);
			var point4:FlxPoint = new FlxPoint(xCoord + 80, yCoord + 100);
			var point5:FlxPoint = new FlxPoint(xCoord - 80, yCoord);
			var point6:FlxPoint = new FlxPoint(xCoord, yCoord - 100);
			var point7:FlxPoint = new FlxPoint(xCoord - 80, yCoord - 100);
			
			trace("Overlaps-- xcoord is " + xCoord + " y coord is " + yCoord);
			
			for each(var c:Character in this.charactersList)
			{
				
				trace("C x is " + c.x + " y is " + c.y);
				if(c.pixelsOverlapPoint(point) || c.pixelsOverlapPoint(point2) || c.pixelsOverlapPoint(point3) || c.pixelsOverlapPoint(point4) 
					||c.pixelsOverlapPoint(point5) || c.pixelsOverlapPoint(point6) || c.pixelsOverlapPoint(point6))
					return true;
				
			}
			return false;
		}
		
		private function onBusGuide(sprite:FlxObject, eventName:String):Boolean
		{
			EventManager.removeEvent(this.busGuide,MouseEvent.MOUSE_UP);
			
			this.busGuide.active = false;
			this.busGuide.visible = false;
			
			this.levelGrp.setAll('visible', true);
			this.levelGrp.setAll('active', true);
			
			return true;
		}
		
		private function onMainMenu(sprite:FlxObject, eventName:String):Boolean
		{
			PlayState.musicPlayer.stop();	
			FlxG.switchState(new MenuState);
			
			return true;
		}
		
		private function onBusGuideButton(sprite:FlxObject, eventName:String):Boolean
		{
			this.levelGrp.setAll('visible', false);
			this.levelGrp.setAll('active', false);
			
			EventManager.registerEvent(this.busGuide,MouseEvent.MOUSE_UP, onBusGuide);
			
			this.busGuide.visible = true;
			this.busGuide.active = true;
			
			return true;
		}
		
		private function onBeforeStage(sprite:FlxObject, eventName:String):Boolean
		{
			sprite.visible = false;
			this.beforeStageText.visible = false;
			this.levelNameText.visible = false;
			
			EventManager.removeEvent(sprite,MouseEvent.MOUSE_UP);
			
			this.remove(this.beforeStage);
			this.remove(this.beforeStageText);
			this.remove(this.levelNameText);
		//	this.remove(sprite);
			
			if(this.name == 1)
			{
//				PlayState.musicPlayer.loadEmbedded(PlayState.level1Music,true);
//				PlayState.musicPlayer.play();
			}
				
			else if(this.name == 2)
			{
//				PlayState.musicPlayer.loadEmbedded(PlayState.level2Music,true);
//				PlayState.musicPlayer.play();
			}
				
			else if(this.name == 3)
			{
//				PlayState.musicPlayer.loadEmbedded(PlayState.level3Music,true);
//				PlayState.musicPlayer.play();
			}
				
			else if(this.name == 4)
			{
//				PlayState.musicPlayer.loadEmbedded(PlayState.level4Music,true);
//				PlayState.musicPlayer.play();
			}
				
			else if(this.name == 5)
			{
//				PlayState.musicPlayer.loadEmbedded(PlayState.level5Music,true);
//				PlayState.musicPlayer.play();
			}
			
			
			return false;
		}
		
		private function checkCharacterAlive():void
		{
			for each(var character:Character in this.charactersList)
			{
				if(!character.live && character.x == character.original.x && character.y == character.original.y)
				{
				//	this.smoke.x = character.x;
					//this.smoke.y = character.y;
					
					character.visible = false;
					character.active = false;
					character.kill();
					character.bubbleText.visible = false;
					character.bubbleText.kill();
					
					
					
					if(character.bubbleTextBox != null)
					{
						character.bubbleTextBox.visible = false;
						character.bubbleTextBox.kill();
					}
					
					else if(character.bubbleTextBoxMedium != null)
					{
						character.bubbleTextBoxMedium.visible = false;
						character.bubbleTextBoxMedium.kill();
						
						character.bubbleTextLarge.visible = false;
						character.bubbleTextLarge.kill();
						
					}
					
					else if(character.bubbleTextBoxLarge != null)
					{
						character.bubbleTextBoxLarge.visible = false;
						character.bubbleTextBoxLarge.kill();
						
						if(character.bubbleTextLarge != null)
						{
							character.bubbleTextLarge.visible = false;
							character.bubbleTextLarge.kill();
						}
							
						else
						{
							character.bubbleBoxPic.visible = false;
							character.bubbleBoxPic.kill();	
						}
					}
						
					else
					{
						character.bubbleTextBoxPic.visible = false;
						character.bubbleTextBoxPic.kill();
						
						character.bubbleBoxPic.visible = false;
						character.bubbleBoxPic.kill();
					}
					
					EventManager.removeEvent(character,MouseEvent.MOUSE_DOWN);
					EventManager.removeEvent(character,MouseEvent.MOUSE_UP);
					
					
				}
				
				
			}
		}
			
	}
}