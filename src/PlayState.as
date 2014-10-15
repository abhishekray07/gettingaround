package
{
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		//probably move all the assets to a different file later
		[Embed(source = "../assets/Landmarks/adm-normal.jpg")]private var admLocPic:Class;
		[Embed(source = "../assets/Landmarks/innovation-normal.jpg")]private var innovationLocPic:Class;
		[Embed(source = "../assets/Landmarks/lwn-normal.jpg")]private var lwnLocPic:Class;
		[Embed(source = "../assets/Landmarks/nie-normal.jpg")]private var nieLocPic:Class;
		[Embed(source = "../assets/Landmarks/ssc-normal.jpg")]private var sscLocPic:Class;
		
		[Embed(source = "../assets/Bus Shelter/adm_shelter.png")]private var admShelterPic:Class;
		[Embed(source = "../assets/Bus Shelter/innovation_shelter.png")]private var innovationShelterPic:Class;
		[Embed(source = "../assets/Bus Shelter/lwn_shelter.png")]private var lwnShelterPic:Class;
		[Embed(source = "../assets/Bus Shelter/nie_shelter.png")]private var nieShelterPic:Class;
		[Embed(source = "../assets/Bus Shelter/ssc_shelter.png")]private var sscShelterPic:Class;
		
		[Embed(source = "../assets/Bus Shelter/adm_floor.png")]private var admGroundPic:Class;
		[Embed(source = "../assets/Bus Shelter/innovation_floor.png")]private var innovationGroundPic:Class;
		[Embed(source = "../assets/Bus Shelter/lwn_floor.png")]private var lwnGroundPic:Class;
		[Embed(source = "../assets/Bus Shelter/nie_floor.png")]private var nieGroundPic:Class;
		[Embed(source = "../assets/Bus Shelter/ssc_floor.png")]private var sscGroundPic:Class;
		
		[Embed(source = "../assets/Buses/bus_179.png")]private var bus179Pic:Class;
		[Embed(source = "../assets/Buses/bus_199.png")]private var bus199Pic:Class;
		[Embed(source = "../assets/Buses/shuttle_A.png")]private var busAPic:Class;
		[Embed(source = "../assets/Buses/shuttle_A02.png")]private var busA2Pic:Class;
		[Embed(source = "../assets/Buses/shuttle_B.png")]private var busBPic:Class;
		[Embed(source = "../assets/Buses/shuttle_B02.png")]private var busB2Pic:Class;
		[Embed(source = "../assets/Buses/shuttle_C.png")]private var busCPic:Class;
		[Embed(source = "../assets/Buses/shuttle_C02.png")]private var busC2Pic:Class;
		[Embed(source = "../assets/Buses/shuttle_D.png")]private var busDPic:Class;
		[Embed(source = "../assets/Buses/shuttle_D02.png")]private var busD2Pic:Class;
		[Embed(source = "../assets/Buses/shuttle_D03.png")]private var busD3Pic:Class;
		
		[Embed(source = "../assets/Splash/gameOver.jpg")]private var losePic:Class;
		[Embed(source = "../assets/Splash/nextStage.jpg")]private var winPic:Class;
		
		
		[Embed(source = "../assets/Graphics/icons/adm.png")]public var admIcon:Class;
		[Embed(source = "../assets/Graphics/icons/can2.png")]public var can2Icon:Class;
		[Embed(source = "../assets/Graphics/icons/innovation.png")]public var innovationIcon:Class;
		[Embed(source = "../assets/Graphics/icons/lwn.png")]public var lwnIcon:Class;
		[Embed(source = "../assets/Graphics/icons/nie.png")]public var nieIcon:Class;
		[Embed(source = "../assets/Graphics/icons/sbs.png")]public var sbsIcon:Class;
		[Embed(source = "../assets/Graphics/icons/src.png")]public var srcIcon:Class;
		[Embed(source = "../assets/Graphics/icons/ssc.png")]public var sscIcon:Class;
		[Embed(source = "../assets/Graphics/icons/technoplaza.png")]public var technoplazaIcon:Class;
		[Embed(source = "../assets/Graphics/icons/grad.png")]public var gradhallIcon:Class;
		[Embed(source = "../assets/Graphics/icons/mrt.png")]public var mrtIcon:Class;
	
//		[Embed(source="../assets/Music/correct.mp3")]public static var correctMusic:Class;
//		[Embed(source="../assets/Music/WRONG.mp3")]public static var wrongMusic:Class;
//		[Embed(source="../assets/Music/applause.mp3")]public static var applauseMusic:Class;
//		[Embed(source="../assets/Music/fail.mp3")]public static var failMusic:Class;
//		
//		[Embed(source="../assets/Music/FBSONGS/LEVEL ONE.mp3")]public static var level1Music:Class;
//		[Embed(source="../assets/Music/FBSONGS/LEVEL 2.mp3")]public static var level2Music:Class;
//		[Embed(source="../assets/Music/FBSONGS/LEVEL THREE.mp3")]public static var level3Music:Class;
//		[Embed(source="../assets/Music/FBSONGS/LEVEL 4.mp3")]public static var level4Music:Class;
//		[Embed(source="../assets/Music/FBSONGS/LEVEL FOUR.mp3")]public static var level5Music:Class;

		//declare the event manager and levels
		protected var eventManager:EventManager;
		
		private var level1:Level;
		private var level2:Level;
		private var level3:Level;
		private var level4:Level;
		private var level5:Level;
		
		private var winSprite:FlxSprite;
		private var loseSprite:FlxSprite;
		
		private var dummyLevel:Level;
		private var nextLevel:String;
		
		public static var ADM:Locations = new Locations("ADM", new Array("199", "B", "A"));
		public static var LWN:Locations = new Locations("LWN", new Array("179", "A"));
		public static var SSC:Locations = new Locations("SSC", new Array("D"));
		public static var NIE:Locations = new Locations("NIE", new Array("B", "199", "C"));
		public static var Can2:Locations = new Locations("CAN 2", new Array("C", "D","A"));
		public static var SBS:Locations = new Locations("SBS", new Array("A"));
		public static var SRC:Locations = new Locations("SRC", new Array("A", "D", "C"));
		public static var TECHNOPLAZA:Locations = new Locations("WKWSCI", new Array("179", "A", "C"));
		public static var INNOVATION:Locations = new Locations("INNO", new Array("179", "A", "C"));
		public static var GRADHALL:Locations = new Locations("H8-11", new Array("199", "B", "C"));
		public static var MRT1:Locations = new Locations("MRT", new Array("199"));
		public static var MRT2:Locations = new Locations("MRT", new Array("179"));
		public static var MRT3:Locations = new Locations("MRT", new Array("X"));
		
		public static var locations:Array = new Array(ADM, LWN, SSC, NIE, Can2, SBS, SRC, TECHNOPLAZA, INNOVATION, GRADHALL, MRT1, MRT2, MRT3);
		
		public static var spawnPoints:Array = new Array(
			new FlxPoint(410,377), new FlxPoint(487,377), new FlxPoint(558,378), new FlxPoint(642,382), new FlxPoint(718, 388),
			new FlxPoint(432,609), new FlxPoint(605,613), new FlxPoint(440,488), new FlxPoint(523,483), new FlxPoint(604,481));
		
		public static var iconDict:Dictionary;
		
		public static var musicPlayer:FlxSound = new FlxSound();
		
		override public function create():void
		{
			super.create();
			
			FlxG.mouse.show();
			
			//add the levels and event manager into the state
		
			this.add(this.eventManager);
			
			this.add(this.level1);
			
		}
		
			
		public function PlayState()
		{
			super();
			
			//Initialise event manager - Needed for more sophisticated Mouse Control
			this.eventManager = new EventManager();
			
			iconDict = new Dictionary();
			iconDict["ADM"] = admIcon;
			iconDict["NIE"] = nieIcon;
			iconDict["CAN 2"] = can2Icon;
			iconDict["SSC"] = sscIcon;
			iconDict["LWN"] = lwnIcon;
			iconDict["SBS"] = sbsIcon;
			iconDict["SRC"] = srcIcon;
			iconDict["INNO"] = innovationIcon;
			iconDict["WKWSCI"] = technoplazaIcon;
			iconDict["H8-11"] = gradhallIcon;
			iconDict["MRT"] = mrtIcon;
			
			this.winSprite = new FlxSprite(0, 0, winPic);
			this.loseSprite = new FlxSprite(0, 0, losePic);
			
			//initialise a level object
			this.level1 = new Level(sscLocPic,sscShelterPic,sscGroundPic, 1000, 60, 3, 1);
			
			//initialise the bus list for a level
			this.level1.busList.push(new Bus(busDPic,"D",1200,60));
			this.level1.busList.push(new Bus(busD2Pic,"D",1200,60));
			this.level1.busList.push(new Bus(busD3Pic,"D",1200,60));
			
			//add characters to the level - Register mouse click events for them
			var character:Character;
			for(var i:int = 0; i<2; i++)
			{
				this.level1.generateCharacter(396, 358, 340, 120, false, "D");
			}
			
			//initialise the queues for the level with their hotspots
			this.level1.queueList.push(new Queue(94, 331, 86, 206, 
				new Array(new FlxPoint(136, 342), new FlxPoint(131, 380),new FlxPoint(126, 418), new FlxPoint(113,417), new FlxPoint(109,508)), "D"));
			
			//very important to call this function - Characters and Buses won't be added to the Scene otherwise
			this.level1.create();
			
		}
		
		public override function destroy():void
		{
			super.destroy();
		}
		
		override public function update():void{
			super.update();
			
			//check for level finish in here
			if(this.level1 != null)
			{
				if(this.level1.levelFinished)
				{
					this.level1.levelFinished = false;
					this.level1.visible = false;
					this.level1.active = false;
					
					this.level1.setAll("visible",false);
					this.level1.setAll("active",false);
					
					trace("Level 1 finished");
					
					
					for each(var chObj:Character in this.level1.charactersList)
					{
						trace("Removing Character");
						EventManager.removeEvent(chObj,MouseEvent.MOUSE_UP);
						EventManager.removeEvent(chObj,MouseEvent.MOUSE_DOWN);
						
						this.level1.remove(chObj,true);
					}
					
					for each(var busObj:Bus in this.level1.busList)
					{
						this.level1.remove(busObj,true);
					} 
					
					
					this.level1.remove(level1.plusSprite,true);
					this.level1.remove(level1.minusSprite,true);
					this.level1.remove(level1.busGuide);
					
					EventManager.removeEvent(level1.busGuideButton, MouseEvent.MOUSE_UP);
					this.level1.remove(level1.busGuideButton);
					
					this.level1.remove(level1.mainMenu);
					
					this.remove(level1,true);
					
					musicPlayer.stop();
					
					this.createLevel2();
				}
			}
			
			else if(this.level2 != null)
			{
				if(this.level2.levelFinished)
				{
					this.level2.levelFinished = false;
					this.level2.visible = false;
					this.level2.active = false;
					
					this.level2.setAll("visible",false);
					this.level2.setAll("active",false);
					
					trace("Level 2 finished");
					
					for each(var chObj:Character in this.level2.charactersList)
					{
						trace("Removing Character");
						EventManager.removeEvent(chObj,MouseEvent.MOUSE_UP);
						EventManager.removeEvent(chObj,MouseEvent.MOUSE_DOWN);
						
						this.level2.remove(chObj,true);
					}
					
					for each(var busObj:Bus in this.level2.busList)
					{
						this.level2.remove(busObj,true);
					} 
					//this.remove(level2,true);
					
					this.level2.remove(level2.plusSprite,true);
					this.level2.remove(level2.minusSprite,true);
					this.level2.remove(level2.busGuide);
					
					EventManager.removeEvent(level2.busGuideButton, MouseEvent.MOUSE_UP);
					this.level2.remove(level2.busGuideButton);
					
					this.level2.remove(level2.mainMenu);
					musicPlayer.stop();
					
					this.createLevel3();
				}
			}
			
			else if(this.level3 != null)
			{
				if(this.level3.levelFinished)
				{
					this.level3.levelFinished = false;
					this.level3.visible = false;
					this.level3.active = false;
					
					this.level3.setAll("visible",false);
					this.level3.setAll("active",false);
					
					trace("Level 3 finished");
					
					for each(var chObj:Character in this.level3.charactersList)
					{
						trace("Removing Character");
						EventManager.removeEvent(chObj,MouseEvent.MOUSE_UP);
						EventManager.removeEvent(chObj,MouseEvent.MOUSE_DOWN);
						
						this.level3.remove(chObj,true);
					}
					
					for each(var busObj:Bus in this.level3.busList)
					{
						this.level3.remove(busObj,true);
					} 
					
					this.level3.remove(level3.plusSprite,true);
					this.level3.remove(level3.minusSprite,true);
					this.level3.remove(level3.busGuide);
					
					EventManager.removeEvent(level3.busGuideButton, MouseEvent.MOUSE_UP);
					this.level3.remove(level3.busGuideButton);
				//	this.remove(level3,true);
					
					this.level3.remove(level3.mainMenu);
					musicPlayer.stop();
					
					this.createLevel4();
				}
			}
			
			else if(this.level4 != null)
			{
				if(this.level4.levelFinished)
				{
					this.level4.levelFinished = false;
					this.level4.visible = false;
					this.level4.active = false;
					
					this.level4.setAll("visible",false);
					this.level4.setAll("active",false);
					
					trace("Level 2 finished");
					
					for each(var chObj:Character in this.level4.charactersList)
					{
						trace("Removing Character");
						EventManager.removeEvent(chObj,MouseEvent.MOUSE_UP);
						EventManager.removeEvent(chObj,MouseEvent.MOUSE_DOWN);
						
						this.level4.remove(chObj,true);
					}
					
					for each(var busObj:Bus in this.level4.busList)
					{
						this.level4.remove(busObj,true);
					} 
					
					this.level4.remove(level4.plusSprite,true);
					this.level4.remove(level4.minusSprite,true);
					this.level4.remove(level4.busGuide);
					
					EventManager.removeEvent(level4.busGuideButton, MouseEvent.MOUSE_UP);
					this.level4.remove(level4.busGuideButton);
					this.level4.remove(level4.mainMenu);
					musicPlayer.stop();
					
					this.createLevel5();
				}
			}
			
			else if(this.level5 != null)
			{
				if(this.level5.levelFinished)
				{
					this.level5.levelFinished = false;
					this.level5.visible = false;
					this.level5.active = false;
					
					this.level5.setAll("visible",false);
					this.level5.setAll("active",false);
					
					trace("Level 5 finished");
					
					for each(var chObj:Character in this.level5.charactersList)
					{
						trace("Removing Character");
						EventManager.removeEvent(chObj,MouseEvent.MOUSE_UP);
						EventManager.removeEvent(chObj,MouseEvent.MOUSE_DOWN);
						
						this.level5.remove(chObj,true);
					}
					
					for each(var busObj:Bus in this.level5.busList)
					{
						this.level5.remove(busObj,true);
					} 
					
					this.level5.remove(level5.plusSprite,true);
					this.level5.remove(level5.minusSprite,true);
					this.level5.remove(level5.busGuide);
					
					EventManager.removeEvent(level5.busGuideButton, MouseEvent.MOUSE_UP);
					this.level5.remove(level5.busGuideButton);
					this.level5.remove(level5.mainMenu);
					
					musicPlayer.stop();
					
					this.finishGame();
				}
			}
			
			
			
		}
		
		private function generateLevel1():void{
			
			this.level1 = new Level(sscLocPic,sscShelterPic,sscGroundPic, 1000, 60, 3, 1);
			
			//initialise the bus list for a level
			this.level1.busList.push(new Bus(busDPic,"D",1200,60));
			this.level1.busList.push(new Bus(busD2Pic,"D",1200,60));
			this.level1.busList.push(new Bus(busD3Pic,"D",1200,60));
			
			//add characters to the level - Register mouse click events for them
			var character:Character;
			for(var i:int = 0; i<2; i++)
			{
				this.level1.generateCharacter(396, 358, 340, 120, false, "D");
			}
			
			//initialise the queues for the level with their hotspots
			this.level1.queueList.push(new Queue(94, 331, 86, 206, 
				new Array(new FlxPoint(136, 342), new FlxPoint(131, 380),new FlxPoint(126, 418), new FlxPoint(113,417), new FlxPoint(109,508)), "D"));
			
			//very important to call this function - Characters and Buses won't be added to the Scene otherwise
			this.level1.create();
		}
		
		private function createLevel2():void{
			
			if(this.level1.points >= this.level1.pointsReq)
			{
				this.level1 = null;
			
				this.winSprite.visible = true;
				this.add(this.winSprite);
				
				//musicPlayer.stop();
//				musicPlayer.loadEmbedded(applauseMusic,false);
//				musicPlayer.play();
				
				nextLevel = "Level 2";
				
				EventManager.registerEvent(this.winSprite,MouseEvent.MOUSE_UP,this.changeLev);
			}
			
			else
			{
				this.loseSprite.visible = true;
				this.add(this.loseSprite);
				
				nextLevel = "Level 1";
				
//				musicPlayer.loadEmbedded(failMusic,false);
//				musicPlayer.play();
//				
				EventManager.registerEvent(this.loseSprite,MouseEvent.MOUSE_UP,this.changeLev);
			}
			
		}
		
		private function generateLevel2():void{
			
			this.level2 = new Level(admLocPic,admShelterPic,admGroundPic, 1200, 75, 2, 2);
			
			//initialise the bus list for a level
			this.level2.busList.push(new Bus(busBPic,"B",1200,60));
			this.level2.busList.push(new Bus(bus199Pic,"199",1200,-80));
			this.level2.busList.push(new Bus(busB2Pic,"B",1200,60));
			this.level2.busList.push(new Bus(bus199Pic,"199",1200,-80));
			
			this.level2.plusSprite.visible = false;
			this.level2.minusSprite.visible = false;
			
			//add characters to the level - Register mouse click events for them
			var character:Character;
			for(var i:int = 0; i<3; i++)
			{
				if(i%2 == 0)
					this.level2.generateCharacter(396, 358, 340, 120, false, "B");
					
				else
					this.level2.generateCharacter(396, 358, 340, 120, false, "199");
				
			}
			
			//initialise the queues for the level with their hotspots
			this.level2.queueList.push(new Queue(96, 337, 96, 200, 
				new Array(new FlxPoint(135, 348), new FlxPoint(129, 391),new FlxPoint(126, 427), new FlxPoint(117,472), new FlxPoint(112,512)), "199"));
			
			this.level2.queueList.push(new Queue(187, 338, 53, 132, 
				new Array(new FlxPoint(212, 350), new FlxPoint(214, 382),new FlxPoint(215, 417), new FlxPoint(213, 455), new FlxPoint(286,446)), "B"));
			
			//very important to call this function - Characters and Buses won't be added to the Scene otherwise
			this.level2.create();
		}
		
		private function createLevel3():void{
			
			if(this.level2.points >= this.level2.pointsReq)
			{
				this.winSprite.visible = true;
				this.add(this.winSprite);
			
				nextLevel = "Level 3";
			
//				musicPlayer.loadEmbedded(applauseMusic,false);
//				musicPlayer.play();
//				
				EventManager.registerEvent(this.winSprite,MouseEvent.MOUSE_UP,this.changeLev);
			}
			
			else
			{
				this.loseSprite.visible = true;
				this.add(this.loseSprite);
				
				nextLevel = "Level 2";
				
//				musicPlayer.loadEmbedded(failMusic,false);
//				musicPlayer.play();
//				
				EventManager.registerEvent(this.loseSprite,MouseEvent.MOUSE_UP,this.changeLev);
				
			}
		}
		private function generateLevel3():void
		{
			if(this.level2 == null || this.level2.points >= this.level2.pointsReq)
			{	
				this.remove(level2,true);
				
				this.level2 = null;
				
				//initialise a level object
				this.level3 = new Level(innovationLocPic,innovationShelterPic,innovationGroundPic, 1400, 90, 4, 3);
				
				//initialise the bus list for a level
				this.level3.busList.push(new Bus(bus179Pic,"X",1200,100));
				this.level3.busList.push(new Bus(busAPic,"A",1200,100));
				this.level3.busList.push(new Bus(bus179Pic,"X",1200,100));
				this.level3.busList.push(new Bus(busA2Pic,"A",1200,60));
				
				var character:Character;
				
				//add characters to the level - Register mouse click events for them
				for(var i:int = 0; i<3; i++)
				{
					if(i%2 == 0)
						this.level3.generateCharacter(480, 360, 240, 100, false, "179");
						
					else
						this.level3.generateCharacter(480, 360, 240, 100, false, "A");
					
				}
				
				//initialise the queues for the level with their hotspots
				this.level3.queueList.push(new Queue(97, 340, 80, 200, 
					new Array(new FlxPoint(135, 350), new FlxPoint(132, 394),new FlxPoint(123, 443), 
						new FlxPoint(111, 486), new FlxPoint(112, 521)), "X"));
				
				this.level3.queueList.push(new Queue(186, 341, 56,130,
					new Array(new FlxPoint(213, 351), new FlxPoint(213, 391),new FlxPoint(217, 435), new FlxPoint(288, 450), new FlxPoint(341, 450)), "A"));
				
				//very important to call this function - Characters and Buses won't be added to the Scene otherwise
				this.level3.create();
					
				
			}
			
			else
			{
				this.remove(level2,true);
				
				this.level2 = null;
				
				this.level2 = new Level(admLocPic,admShelterPic,admGroundPic, 1200, 75, 2, 2);
				
				//initialise the bus list for a level
				this.level2.busList.push(new Bus(busBPic,"B",1200,60));
				this.level2.busList.push(new Bus(bus199Pic,"199",1200,-80));
				this.level2.busList.push(new Bus(busB2Pic,"B",1200,60));
				this.level2.busList.push(new Bus(bus199Pic,"199",1200,-80));
				
				//add characters to the level - Register mouse click events for them
				var character:Character;
				for(var i:int = 0; i<3; i++)
				{
					if(i%2 == 0)
						this.level2.generateCharacter(480, 360, 240, 100, false, "B");
						
					else
						this.level2.generateCharacter(480, 360, 240, 100, false, "199");
				}
				
				//initialise the queues for the level with their hotspots
				this.level2.queueList.push(new Queue(96, 337, 96, 200, 
					new Array(new FlxPoint(135, 348), new FlxPoint(129, 391),new FlxPoint(126, 427), new FlxPoint(117,472), new FlxPoint(112,512)), "199"));
				
				this.level2.queueList.push(new Queue(187, 338, 53, 132, 
					new Array(new FlxPoint(212, 350), new FlxPoint(214, 382),new FlxPoint(215, 417), new FlxPoint(213, 455), new FlxPoint(286,446)), "B"));
				
				//very important to call this function - Characters and Buses won't be added to the Scene otherwise
				this.level2.create();
				
			}
		}
		
		public function createLevel4():void{
			
			
			if(this.level3.points >= this.level3.pointsReq)
			{
				this.winSprite.visible = true;
				this.add(this.winSprite);
				
				nextLevel = "Level 4";
				
//				musicPlayer.loadEmbedded(applauseMusic,false);
//				musicPlayer.play();
//				
				EventManager.registerEvent(this.winSprite,MouseEvent.MOUSE_UP,this.changeLev);
			}
			
			else
			{
				this.loseSprite.visible = true;
				this.add(this.loseSprite);
				
				nextLevel = "Level 3";
				
//				musicPlayer.loadEmbedded(failMusic,false);
//				musicPlayer.play();
//				
				EventManager.registerEvent(this.loseSprite,MouseEvent.MOUSE_UP,this.changeLev);
			}
		}
		
		public function generateLevel4():void{
			
			if(this.level3 == null || this.level3.points >= this.level3.pointsReq)
			{
				this.remove(level3,true);
				
				this.level3 = null;
				
				//initialise a level object
				this.level4 = new Level(lwnLocPic,lwnShelterPic,lwnGroundPic, 1600, 105, 3, 4);
				
				//initialise the bus list for a level
				this.level4.busList.push(new Bus(bus179Pic,"179",1200,100));
				this.level4.busList.push(new Bus(busAPic,"A",1200,100));
				this.level4.busList.push(new Bus(bus179Pic,"179",1200,100));
				this.level4.busList.push(new Bus(busA2Pic,"A",1200,100));
				
				var character:Character;
				//add characters to the level - Register mouse click events for them
				for(var i:int = 0; i<3; i++)
				{
					this.level4.generateCharacter(480, 360, 240, 100, false, "179");
				}
				
				//initialise the queues for the level with their hotspots
				this.level4.queueList.push(new Queue(96, 340, 83, 215, 
					new Array(new FlxPoint(136, 348), new FlxPoint(132,389),new FlxPoint(126, 411), new FlxPoint(120,457),new FlxPoint(113, 515)), "179"));
				
				this.level4.queueList.push(new Queue(189, 339, 50, 130, new Array(new FlxPoint(210, 346), new FlxPoint(217, 377),
					new FlxPoint(216, 413), new FlxPoint(217,452),new FlxPoint(282, 451)), "A"));
				
				
				//very important to call this function - Characters and Buses won't be added to the Scene otherwise
				this.level4.create();
			}
			
			else
			{
				this.remove(level3,true);
				
				this.level3 = null;
				
				//initialise a level object
				this.level3 = new Level(innovationLocPic,innovationShelterPic,innovationGroundPic, 1400, 90, 4, 3);
				
				//initialise the bus list for a level
				this.level3.busList.push(new Bus(bus179Pic,"X",1200,100));
				this.level3.busList.push(new Bus(busAPic,"A",1200,100));
				this.level3.busList.push(new Bus(bus179Pic,"X",1200,100));
				this.level3.busList.push(new Bus(busA2Pic,"A",1200,100));
				
				var character:Character;
				
				//add characters to the level - Register mouse click events for them
				for(var i:int = 0; i<3; i++)
				{
					if(i%2 == 0)
						this.level3.generateCharacter(480, 360, 240, 100, false, "179");
						
					else
						this.level3.generateCharacter(480, 360, 240, 100, false, "A");
					
				}
				
				//initialise the queues for the level with their hotspots
				this.level3.queueList.push(new Queue(97, 340, 80, 200, 
					new Array(new FlxPoint(135, 350), new FlxPoint(132, 394),new FlxPoint(123, 443), 
						new FlxPoint(111, 486), new FlxPoint(112, 521)), "X"));
				
				this.level3.queueList.push(new Queue(186, 341, 56,130,
					new Array(new FlxPoint(213, 351), new FlxPoint(213, 391),new FlxPoint(217, 435), new FlxPoint(288, 450), new FlxPoint(341, 450)), "A"));
				
				//very important to call this function - Characters and Buses won't be added to the Scene otherwise
				this.level3.create();
			}
			
		}
		
		public function createLevel5():void{
			
			if(this.level4 == null || this.level4.points >=  this.level4.pointsReq)
			{
				this.winSprite.visible = true;
				this.add(this.winSprite);
				
				nextLevel = "Level 5";
				
//				musicPlayer.loadEmbedded(applauseMusic,false);
//				musicPlayer.play();
				
				EventManager.registerEvent(this.winSprite,MouseEvent.MOUSE_UP,this.changeLev);
			}
			
			else
			{
				this.loseSprite.visible = true;
				this.add(this.loseSprite);
				
				nextLevel = "Level 4";
				
//				musicPlayer.loadEmbedded(failMusic,false);
//				musicPlayer.play();
				
				EventManager.registerEvent(this.loseSprite,MouseEvent.MOUSE_UP,this.changeLev);
				
			}
		}
		
		public function generateLevel5():void{
			
			if(this.level4 == null || this.level4.points >=  this.level4.pointsReq)
			{
				this.remove(level4,true);
				
				this.level4 = null;
				
				//initialise a level object
				this.level5 = new Level(nieLocPic,nieShelterPic,nieGroundPic, 1800, 120, 3, 5);
				
				//initialise the bus list for a level
				this.level5.busList.push(new Bus(busCPic,"C",1200,80));
				this.level5.busList.push(new Bus(busBPic,"B",1200,80));
				this.level5.busList.push(new Bus(bus199Pic,"199",1200,-80));
				this.level5.busList.push(new Bus(busC2Pic,"C",1200,80));
				this.level5.busList.push(new Bus(busB2Pic,"B",1200,80));
				this.level5.busList.push(new Bus(bus199Pic,"199",1200,-80));
				
				var character:Character;
				
				//add characters to the level - Register mouse click events for them
				for(var i:int = 0; i<3; i++)
				{
					if(i == 0)
						this.level5.generateCharacter(480, 360, 240, 100, false, "C");
						
					else if(i == 1)
						this.level5.generateCharacter(480, 360, 240, 100, false, "B");
					
					else
						this.level5.generateCharacter(480, 360, 240, 100, false, "199");
					
				}
				
				//initialise the queues for the level with their hotspots
				this.level5.queueList.push(new Queue(97, 331, 80, 210, 
					new Array(new FlxPoint(136, 345), new FlxPoint(130, 385),new FlxPoint(124, 432),
						new FlxPoint(117, 488),new FlxPoint(176, 513)), "199"));
				
				this.level5.queueList.push(new Queue(188, 331, 46, 135, new Array(new FlxPoint(212, 345), new FlxPoint(218, 384),
					new FlxPoint(215, 410), new FlxPoint(217, 439),new FlxPoint(258, 450)), "B"));
				
				this.level5.queueList.push(new Queue(246, 332, 61, 85, new Array(new FlxPoint(279, 346), new FlxPoint(288, 371),
					new FlxPoint(296, 405), new FlxPoint(344, 397),new FlxPoint(393, 399)), "C"));
				
				//very important to call this function - Characters and Buses won't be added to the Scene otherwise
				this.level5.create();
			}
			
			else
			{
				this.remove(level4,true);
				
				this.level4 = null;
				
				//initialise a level object
				this.level4 = new Level(lwnLocPic,lwnShelterPic,lwnGroundPic, 1600, 105, 3, 4);
				
				//initialise the bus list for a level
				this.level4.busList.push(new Bus(bus179Pic,"179",1200,80));
				this.level4.busList.push(new Bus(busAPic,"A",1200,80));
				
				this.level4.busList.push(new Bus(bus179Pic,"179",1200,80));
				this.level4.busList.push(new Bus(busA2Pic,"A",1200,80));
				var character:Character;
				//add characters to the level - Register mouse click events for them
				for(var i:int = 0; i<3; i++)
				{
					
					this.level4.generateCharacter(480, 360, 240, 100, false, "A");
				}
				
				//initialise the queues for the level with their hotspots
				this.level4.queueList.push(new Queue(96, 340, 83, 215, 
					new Array(new FlxPoint(136, 348), new FlxPoint(132,389),new FlxPoint(126, 411), new FlxPoint(120,457),new FlxPoint(113, 515)), "179"));
				
				this.level4.queueList.push(new Queue(189, 339, 50, 130, new Array(new FlxPoint(210, 346), new FlxPoint(217, 377),
					new FlxPoint(216, 413), new FlxPoint(217,452),new FlxPoint(282, 451)), "A"));
				
				//very important to call this function - Characters and Buses won't be added to the Scene otherwise
				this.level4.create();
			}
			
		}
		
		public function finishGame():void{
			
			if(this.level5.points >=  this.level5.pointsReq)
			{
				FlxG.switchState(new WinScreen);
			}
				
			else
			{
				this.loseSprite.visible = true;
				this.add(this.loseSprite);
				
				nextLevel = "Level 6";
				
//				musicPlayer.loadEmbedded(failMusic,false);
//				musicPlayer.play();
//				
				EventManager.registerEvent(this.loseSprite,MouseEvent.MOUSE_UP,this.changeLev);
				
			}
		}
		
		public function generateLastLevel():void{
			
				this.remove(level5,true);
				
				this.level5 = null;
				
				//initialise a level object
				this.level5 = new Level(nieLocPic,nieShelterPic,nieGroundPic, 1800, 120, 3, 5);
				
				//initialise the bus list for a level
				this.level5.busList.push(new Bus(busCPic,"C",1200,60));
				this.level5.busList.push(new Bus(busBPic,"B",1200,60));
				this.level5.busList.push(new Bus(bus199Pic,"199",1200,-80));
				
				this.level5.busList.push(new Bus(busC2Pic,"C",1200,60));
				this.level5.busList.push(new Bus(busB2Pic,"B",1200,60));
				this.level5.busList.push(new Bus(bus199Pic,"199",1200,-80));
				
				var character:Character;
				
				//add characters to the level - Register mouse click events for them
				for(var i:int = 0; i<3; i++)
				{
					if(i == 0)
						this.level5.generateCharacter(480, 360, 240, 100, false, "C");
						
					else if(i == 1)
						this.level5.generateCharacter(480, 360, 240, 100, false, "B");
						
					else
						this.level5.generateCharacter(480, 360, 240, 100, false, "199");
					
				}
				
				//initialise the queues for the level with their hotspots
				this.level5.queueList.push(new Queue(97, 331, 80, 210, 
					new Array(new FlxPoint(136, 345), new FlxPoint(130, 385),new FlxPoint(124, 432),
						new FlxPoint(117, 488),new FlxPoint(176, 513)), "199"));
				
				this.level5.queueList.push(new Queue(188, 331, 46, 135, new Array(new FlxPoint(212, 345), new FlxPoint(218, 384),
					new FlxPoint(215, 410), new FlxPoint(217, 439),new FlxPoint(258, 450)), "B"));
				
				this.level5.queueList.push(new Queue(246, 332, 61, 85, new Array(new FlxPoint(279, 346), new FlxPoint(288, 371),
					new FlxPoint(296, 405), new FlxPoint(344, 397),new FlxPoint(393, 399)), "C"));
				
				//very important to call this function - Characters and Buses won't be added to the Scene otherwise
				this.level5.create();
			
		}
		
		
		public function changeLev(screenSprite:FlxObject, eventName:String):Boolean
		{
			EventManager.removeEvent(screenSprite,MouseEvent.MOUSE_UP);
			
			musicPlayer.stop();
			
			screenSprite.visible = false;
			screenSprite.active = false;
			this.remove(screenSprite);
			
			switch(nextLevel)
			{
				case "Level 1":
					this.generateLevel1();
					dummyLevel = this.level1;
					break;
				
				case "Level 2":
					this.generateLevel2();
					dummyLevel = this.level2;
					break;
				
				case "Level 3":
					this.generateLevel3();
					dummyLevel = this.level3;
					break;
				
				case "Level 4":
					this.generateLevel4();
					dummyLevel = this.level4;
					break;
				
				case "Level 5":
					this.generateLevel5();
					dummyLevel = this.level5;
					break;
				
				case "Level 6":
					this.generateLastLevel();
					dummyLevel = this.level5;
					break;
			}
			
			dummyLevel.visible = true;
			dummyLevel.setAll("visible",true);
			
			dummyLevel.active = true;
			dummyLevel.setAll('active',true);
			
			dummyLevel.plusSprite.visible = false;
			dummyLevel.minusSprite.visible = false;
			dummyLevel.busGuide.visible = false;
			
			this.add(dummyLevel);
			
			return true;
		}
		
	}
}
