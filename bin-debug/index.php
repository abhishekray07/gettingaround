<?php
/**
 * Copyright 2011 Facebook, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may
 * not use this file except in compliance with the License. You may obtain
 * a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations
 * under the License.
 */

require '../src/facebook.php';

// Create our Application instance (replace this with your appId and secret).
$facebook = new Facebook(array(
  'appId'  => '153628084722668',
  'secret' => '983750c1db6e4f6b74e9265ef866ab16',
));


// get user UID
$fb_user_id = $facebook->getUser();

    // get the url where to redirect the user
$location = "". $facebook->getLoginUrl(array(
    'canvas'    => 1,
    'fbconnect' => 0,
    'scope' => 'email,publish_stream',
	'redirect_uri' => 'http://apps.facebook.com/abhishekfbapp/'
));

// check if we have valid user
if ($fb_user_id) {
    try {
        // Proceed knowing you have a logged in user who's authenticated.
        $fb_user_profile = $facebook->api('/me');   

    } catch (FacebookApiException $e) {
        $fb_user_id = NULL;
        // seems we don't have enough permissions
        // we use javascript to redirect user instead of header() due to Facebook bug
        print '<script language="javascript" type="text/javascript"> top.location.href="'. $location .'"; </script>';

        // kill the code so nothing else will happen before user gives us permissions
        die();
    }

} else {
    // seems our user hasn't logged in, redirect him to a FB login page

    print '<script language="javascript" type="text/javascript"> top.location.href="'. $location .'"; </script>';

    // kill the code so nothing else will happen before user gives us permissions
    die();
}

// at this point we have an logged in user who has given permissions to our APP
// basic user info can be fetched easily
//print "Welcome to my app". $fb_user_profile['name'];
?>

<!DOCTYPE html>
 <!-- saved from url=(0014)about:internet -->
 <!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
	<head>	 	
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
		<script type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>	
		
		 <script type="text/javascript">
<!--
    function showInvite(){
        newwindow=window.open('invite.html','Invite Your Friends','height=400,width=400');
		if (window.focus) {newwindow.focus()}
		return true;

    }
    
    function showFBPage(){
        newwindow=window.open('http://www.facebook.com/groups/NTUsg/','NTU');
		if (window.focus) {newwindow.focus()}
		return true;

    }
 
    function hideInvite(){
        document.getElementById('invite').style.display = 'none';
        document.getElementById('invite').src = "about:blank";
    }
</script>

	</head>
	<body>
		<div id="fb-root"></div>
		<div id="flashContent">
			<h1>You need at least Flash Player 9.0 to view this page.</h1>
			<p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>
		</div>  
		<script type="text/javascript">
			//Dynamic publishing with swfObject 
			
			//A 'name' attribute with the same value as the 'id' is REQUIRED for Chrome/Mozilla browsers
			swfobject.embedSWF("NTUFacebookGame.swf", "flashContent", "800", "600", "9.0", null, null, null, {name:"flashContent"}); 			
		</script>
	</body>
</html>