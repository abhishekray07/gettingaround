package
{	
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;

	public class EventManager extends FlxObject
	{
		protected static var instance:EventManager=null;
		protected var eventDict:Dictionary=new Dictionary();
		protected var eventFiredDict:Dictionary=new Dictionary();
		
		public function EventManager()
		{
			EventManager.instance=this;
		}
		
		public override function destroy():void
		{
			super.destroy();
			this.internalRemoveAllEvents();
			this.eventDict=null;
			this.eventFiredDict=null;
		}
		
		/**
		 * Register an event for a FlxObject
		 * @param callback - a Boolean function that takes arguments of FlxObject and String
		 * ie: <code>function callback(object:FlxObject,event:String):Boolean</code>
		 */
		public static function registerEvent(item:FlxObject, eventName:String, callback:Function, priority:int=0):void
		{
			EventManager.instance.internalRegisterEvent(item, eventName, callback, priority);
		}
		
		protected function internalRegisterEvent(item:FlxObject, eventName:String, callback:Function, priority:int):void
		{
			if (!this.eventFiredDict.hasOwnProperty(eventName))
				this.eventFiredDict[eventName]=false;
			
			var eventFiredDict=this.eventFiredDict;
			var eventHandler:Function=function eventHandler(event:MouseEvent):void
			{
				if ( item == null )
					return;

				if (GameGlobals.mouseOverlaps(item))
				{	
					if (eventFiredDict[eventName]==false)
					{
						var functionResult:Object=callback(item,event);
						if (functionResult==null)
							throw new Error("Oh no dear programmer please register events with BOOLEAN callbacks - that means it returns true or false");
						if (functionResult==true)
							eventFiredDict[eventName]=true;
					}
				}
			};
			if (this.eventDict[item]==null)
				this.eventDict[item]=new Dictionary();
			if (this.eventDict[item][eventName]!=null)
				this.internalRemoveEvent(item,eventName);
			this.eventDict[item][eventName]=eventHandler;
			FlxG.stage.addEventListener(eventName, eventHandler,false,priority,true);
		}
		
		public static function removeEvent(item:FlxObject, eventName:String):void
		{
			EventManager.instance.internalRemoveEvent(item, eventName);
		}
		
		protected function internalRemoveEvent(item:FlxObject, eventName:String):void
		{
			if(this.eventDict[item] != null)
				var f:Function=this.eventDict[item][eventName] as Function;
			
			if(f != null)
			{
				FlxG.stage.removeEventListener(eventName,f);
				this.eventDict[item][eventName]=null;
			}
		}
		
		protected function internalRemoveObjectEvents(item:FlxObject):void
		{
			for (var event in this.eventDict[item])
			{
				this.internalRemoveEvent(item,event);
			}
		}
		
		protected function internalRemoveAllEvents():void
		{
			for (var item in this.eventDict)
			{
				this.internalRemoveObjectEvents(item as FlxObject);
			}
		}
		
		public override function update():void
		{
			super.update();
			for (var key:String in this.eventFiredDict)
				this.eventFiredDict[key]=false;
		}
		
		public static function generateCallbackWrapper(func:Function, useEntireCursor:Boolean=true, pixelPrecision:Boolean=false):Function
		{
			return function callback( flxobj : FlxObject, event:String) : Boolean
			{
				//if not defaults
				if (useEntireCursor!=true || pixelPrecision!=false)
				{
					if (!GameGlobals.mouseOverlaps(flxobj,useEntireCursor,pixelPrecision))
						return false;
				}
				func();
				return true;
			}
		}
	}
}
