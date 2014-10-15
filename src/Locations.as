package
{
	public class Locations
	{
		private var _buses:Array;
		
		private var _name:String;
		
		
		public function Locations(name:String, buses:Array)
		{
			this.buses = buses;
			this.name = name;
			
		}

		public function get buses():Array
		{
			return _buses;
		}

		public function set buses(value:Array):void
		{
			_buses = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

	}
}