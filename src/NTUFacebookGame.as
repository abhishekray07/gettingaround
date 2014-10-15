package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import org.flixel.FlxState;
	
	[Frame(factoryClass="Preloader")]
	
	public class NTUFacebookGame extends FlxGame
	{	
		public var bgcolor:uint = 0xffa51cFF;
		
		public function NTUFacebookGame()
		{
			super(800,600,OpeningCutScene,1);
			
			FlxG.bgColor = this.bgcolor;	
		}
	}
}