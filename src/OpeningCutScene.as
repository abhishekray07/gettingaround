package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;

	public class OpeningCutScene extends FlxState
	{
		[Embed(source = "../assets/Splash/IntroCutscene/introC_000.jpg")]private var intro1:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_001.jpg")]private var intro2:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_002.jpg")]private var intro3:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_003.jpg")]private var intro4:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_004.jpg")]private var intro5:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_005.jpg")]private var intro6:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_006.jpg")]private var intro7:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_007.jpg")]private var intro8:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_008.jpg")]private var intro9:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_009.jpg")]private var intro10:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_010.jpg")]private var intro11:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_011.jpg")]private var intro12:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_012.jpg")]private var intro13:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_013.jpg")]private var intro14:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_014.jpg")]private var intro15:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_015.jpg")]private var intro16:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_016.jpg")]private var intro17:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_017.jpg")]private var intro18:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_018.jpg")]private var intro19:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_019.jpg")]private var intro20:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_020.jpg")]private var intro21:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_021.jpg")]private var intro22:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_022.jpg")]private var intro23:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_023.jpg")]private var intro24:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_024.jpg")]private var intro25:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_025.jpg")]private var intro26:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_026.jpg")]private var intro27:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_027.jpg")]private var intro28:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_028.jpg")]private var intro29:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_029.jpg")]private var intro30:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_030.jpg")]private var intro31:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_031.jpg")]private var intro32:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_032.jpg")]private var intro33:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_033.jpg")]private var intro34:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_034.jpg")]private var intro35:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_035.jpg")]private var intro36:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_036.jpg")]private var intro37:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_037.jpg")]private var intro38:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_038.jpg")]private var intro39:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_039.jpg")]private var intro40:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_040.jpg")]private var intro41:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_041.jpg")]private var intro42:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_042.jpg")]private var intro43:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_043.jpg")]private var intro44:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_044.jpg")]private var intro45:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_045.jpg")]private var intro46:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_046.jpg")]private var intro47:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_047.jpg")]private var intro48:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_048.jpg")]private var intro49:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_049.jpg")]private var intro50:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_050.jpg")]private var intro51:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_051.jpg")]private var intro52:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_052.jpg")]private var intro53:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_053.jpg")]private var intro54:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_054.jpg")]private var intro55:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_055.jpg")]private var intro56:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_056.jpg")]private var intro57:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_057.jpg")]private var intro58:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_058.jpg")]private var intro59:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_059.jpg")]private var intro60:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_060.jpg")]private var intro61:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_061.jpg")]private var intro62:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_062.jpg")]private var intro63:Class;
		[Embed(source = "../assets/Splash/IntroCutscene/introC_063.jpg")]private var intro64:Class;
		
		private var slideShow:Array;
		private var timer:Number = 0.0625;
		private var currentScene:int = 0;
		private var currentSceneSprite:FlxSprite;
		
		public function OpeningCutScene()
		{
			slideShow = new Array( intro1, intro2, intro3, intro4, intro5, intro6, intro7, intro8, intro9, intro10,
				intro11, intro12, intro13, intro14, intro15, intro16, intro17, intro18, intro19, intro20,
				intro21, intro22, intro23, intro24, intro25, intro26, intro27, intro28, intro29, intro30,
				intro31, intro32, intro33, intro34, intro35, intro36, intro37, intro38, intro39, intro40,
				intro41, intro42, intro43, intro44, intro45, intro46, intro47, intro48, intro49, intro50,
				intro51, intro52, intro53, intro54, intro55, intro56, intro57, intro58, intro59, intro60,
				intro61, intro62, intro63, intro64)
		}
		
		override public function update():void
		{
			
			
			if(this.timer > 0 )
			{
				this.timer -= FlxG.elapsed;
			}
			
			else if(this.currentScene == this.slideShow.length - 1)
			{
				this.timer = 1;
				this.currentScene++;
			}
			
			else if(this.currentScene >= this.slideShow.length)
			{
				FlxG.switchState(new MenuState);
			}
			
			else 
			{
				if(this.currentSceneSprite != null)
				{
					this.currentSceneSprite.visible = false;
					this.remove(this.currentSceneSprite);
				}
				
				this.currentSceneSprite = new FlxSprite(0,0, this.slideShow[currentScene]);
				this.currentSceneSprite.visible = true;
				this.add(this.currentSceneSprite);
				this.currentScene++;
				
				this.timer = 0.0625;
				
			}
		}
	}
}