package
{
	import org.flixel.FlxSprite;
	
	public class Smoke extends FlxSprite
	{
		[Embed(source = "../assets/Graphics/smoke.png")]private var smokePic:Class;
		
		public function Smoke(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y);
			
			this.loadGraphic(smokePic, true, false, 80, 140);
			this.addAnimation("smoke", [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],16,false);
		}
		
		public function playAnim():void{
			this.play("smoke");
		}
		
		override public function update():void{
			this.play("smoke");
		}
	}
}