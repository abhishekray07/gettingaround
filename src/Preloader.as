package
{	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.flixel.FlxU;
	import org.flixel.system.FlxPreloader;
	
	//import NTUFacebookGame;
	
	public class Preloader extends FlxPreloader
	{
		//var ntuFacebook:NTUFacebookGame;
		
		[Embed(source="../assets/Splash/intro.jpg")] protected var LoadingScreenPic:Class;
		[Embed(source="../assets/Graphics/loading-base.png")] protected var LoadingBasePic:Class;
		[Embed(source="../assets/Graphics/loading-bar.png")] protected var LoadingBarPic:Class;
		
		private var _loadingScreen:Bitmap;
		private var _loadingBase:Bitmap;
		private var _loadingBar:Bitmap;
		
		private var _percentBar:Bitmap;
		
		public function Preloader()
		{
			this.className = "NTUFacebookGame";
			super();
		}
		
		
		override protected function create(): void 
		{
			// The buffer, add every graphics on it.
			_buffer = new Sprite();
			_buffer.width = 800;
			_buffer.height = 600;
			
			_buffer.scaleX = 1;
			_buffer.scaleY = 1;
			addChild(_buffer);
			
			// Background
			_width = 800;
			_height = 600;
			var bitmap:Bitmap = new LoadingScreenPic();
			_buffer.addChild(bitmap);
			
			// This shows the bar.
			_bmpBar = new Bitmap(new BitmapData(1,7,false,0xFFFFFF));
			_bmpBar.x = 4;
			_bmpBar.y = 550;
			_buffer.addChild(_bmpBar);
			
			// This displays the percentage that has been loaded.
			_text = new TextField();
			_text.defaultTextFormat = new TextFormat("system",8,0xFFFFFF);
			_text.embedFonts = true;
			_text.selectable = false;
			_text.multiline = false;
			_text.x = 18;
			_text.y = _bmpBar.y - 11;
			_text.width = 80;
			_buffer.addChild(_text);
		}
		
		override protected function update(Percent: Number): void 
		{
			_bmpBar.scaleX = Percent*(800-8);
			trace("scaleX" + _bmpBar.scaleX);
			
			if(Percent >= 1)
			{
				_text.text = "Completed";
				_text.setTextFormat(_text.defaultTextFormat);
				return;
			}
			_text.text = "Loading: " + FlxU.floor(Percent*100)+"%";
			_text.setTextFormat(_text.defaultTextFormat);
		}
		
	}
}