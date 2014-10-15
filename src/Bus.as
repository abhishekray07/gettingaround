package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Abhishek
	 */
	public class Bus extends FlxSprite
	{
		private var _move:Boolean;
		private var _moveOnce:Boolean;
		private var _name:String;
		private var _status:int; // 0 - not moving - outside 1- moving 2-arrived 3-leaving
		
		public function get status():int
		{
			return _status;
		}

		public function set status(value:int):void
		{
			_status = value;
		}

		public function get move () : Boolean
		{
			return _move;
		}
		
		public function set move ( move:Boolean ) : void
		{
			_move = move;
		}
		
		public function get moveOnce () : Boolean
		{
			return _moveOnce;
		}
		
		public function set moveOnce ( moveOnce:Boolean ) : void
		{
			_moveOnce = moveOnce;
		}
		
		public function get name () : String
		{
			return _name;
		}
		
		public function set name ( name:String ) : void
		{
			_name = name;
		}
		
		public function Bus(graphic:Class, name:String, x:int, y:int) 
		{
			super(x, y, graphic);
			this._name = name;
			this.visible = false;
			this._move = false;
			this._moveOnce = false;
			this._status = 0;
		}
		
		override public function update():void
		{
			if(this.status == 1)
			{
				this.visible = true;
				this.x -= 8;
				
				if (this.x <= 70)
				{
					//this._move = false;
					this.status = 2;
					trace("Status = 2");
				}
			}
			
			else if(this.status == 4)
			{	
				this.x -= 8;
				
				if(this.x < -this.width)
				{	this.visible= false;
					this.status = 5;
				}
			}
			
		}
		
	}

}