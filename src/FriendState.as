package  
{
	/**
	 * ...
	 * @author Abhishek
	 */
	
	import com.facebook.graph.data.FacebookSession;
	import org.flixel.*;
	import com.facebook.graph.Facebook;
	import flash.external.ExternalInterface;
	
	 
	public class FriendState extends FlxState
	{
		protected static const APP_ID:String = "153628084722668";
		private var outputTxt:FlxText;
		private var publishPost:FlxButton;
		private var inviteFriends:FlxButton;
		public function FriendState()
		{
		}
		
		
		override public function create():void
		{
			FlxG.mouse.show();
	
			this.outputTxt = new FlxText(250, 10, 300, "");
			add(this.outputTxt);
			
			this.publishPost = new FlxButton(220, 30, "Publish Post", onPublish);
			add(this.publishPost);
			
			this.inviteFriends = new FlxButton(220, 60, "Invite Friends", onFriends);
			add(this.inviteFriends);
			
			Facebook.init(APP_ID, onInit);
			
		}
		
		protected function onInit(result:Object, fail:Object):void {						
			if (result) { //already logged in because of existing session
				Facebook.api('/me', handleMe);
				
			} else {
				this.outputTxt.text = "onInit, Not Logged In\n";
			}
		}
		
		private function handleMe(result:Object, fail:Object):void
		{
			this.outputTxt.text = "Hello " + result.name;
		}
		
		private function onPublish():void
		{
			var o:Object;
			o = {
					message: 'come and check out this app',
					name: 'Abhisheks APP',
					caption: 'Abhisheks FB App',
					description: 'A small app made by abhishek' ,
					link: 'http://apps.facebook.com/abhishekfbapp'
				};
			Facebook.api('/me/feed/', handlePublish, o, 'POST');
		}
		
		private function handlePublish(result:Object, fail:Object):void
		{
			if (result)
				this.outputTxt.text = "Successfully Published";
		}
		
		private function onFriends():void
		{
			ExternalInterface.call("showInvite()");
		}
	}

}