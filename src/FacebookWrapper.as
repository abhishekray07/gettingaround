package  
{
	/**
	 * ...
	 * @author Abhishek
	 */
//	import com.adobe.serialization.json.JSON;
//	import com.facebook.graph.Facebook;
//	import com.facebook.graph.data.FacebookSession;
//	import com.facebook.graph.net.FacebookRequest;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	
	import org.flixel.*;

	public class FacebookWrapper
	{
		protected static const APP_ID:String = "153628084722668"; //Your App Id
		protected static const APP_URL:String = "http://apps.facebook.com/abhishekfbapp/"; //Your App URL as specified in facebook.com/developers app settings
	
		private var publishPost:FlxButton;
		private var inviteFriends:FlxButton;
		
		public function FacebookWrapper() 
		{	
			//Facebook.init(APP_ID);
			//onPublish();		
		}
		
		public function onPublish():void
		{
			ExternalInterface.call("fb_publish()");
		}
		
	
		private function postToWallCompleteHandler(response:Object, fail:Object):void{
			trace("response: ", response, "fail: ", fail);
		}
		
		public function onFriends():void
		{
			ExternalInterface.call("showInvite()");
		}
	}

}