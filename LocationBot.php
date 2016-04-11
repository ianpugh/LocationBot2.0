<?php

/* 
 * LocationBot - Originally created by https://www.reddit.com/u/ianp in 2013.
 *
 * To address any related concerns prior to them being expressed, this *IS* largely a script and not a full-blown application.
 *
 * https://github.com/ianpugh/LocationBot2.0
 * 
 * This project is licensed under the terms of the MIT license. (See License.md)
 *
 * For more information, see the project repository on GitHub:
 *
 * https://github.com/ianpugh/LocationBot2.0
 *
 * In order to run LocationBot, you should have the following:
 *
 * 1) Shared or dedicated web host capable of running PHP 5.2+
 * 2) Ability to schedule jobs via CRON or similar. Note that the identity running the CRON should have access to "cookie.txt" for storing authentication information.
 * 3) Set LocationBot to poll every x number of minutes. Currently, he checks ever minute. This may need to be increased as traffic increases or the number of subs he monitors increases.
 * 4) Access to a MySQL database where you can run the attached SQL script.
 * 5) Under no circumstances should you run LocationBot against a subreddit without prior consent from the moderators of that subreddit. This will likely result in someone banning your account.
 *
 */
 
define ('VERSION', '2.0.0');		// Versioning should following the semantic versioning guidelines outlined here: http://semver.org/

define ('USER_AGENT', 'User-Agent: locationbot/' . VERSION . ' by ianp');

require_once ('reddit.php');			// Methods for Authentication, Getting Posts, and Posting
require_once ('data.php');				// Simple factory for getting a database connection.
require_once ('credentials.php');		// Credentials for the database and user.
require_once ('action.php');			// Action to take when we post a reply.
require_once ('mention_action.php'); 	// Action to take when our name is mentioned.	

// Start doing "bot" stuff.

$data_connection = Data::GetConnection();

$reddit = new Reddit(REDDIT_USERNAME, REDDIT_PASSWORD);
$reddit->Login();

// Get collections of subreddits that we should be monitoring.

$query = "SELECT rec_id, name FROM Subreddit WHERE active=1";
$result = $data_connection->query($query);

$subreddit = array();

while ($row = $result->fetch_assoc())
{
		$subreddit[$row['name']] = $row['rec_id'];
}

// Get list of locations that we should look for.

$query = "SELECT name FROM Location";
$result = $data_connection->query($query);
$location = array();

while ($row = $result->fetch_assoc())
{        
		$escaped_name = preg_quote($row['name']);
		array_push($location, "\b($escaped_name)\b");
}

// Create a regular expression based on the locations array.

$locations_regex  = "/" . implode('|', $location) . "/i";

// Get list of posts that we need to parse for each subreddit we monitor.

foreach ($subreddit as $key => $value)
{
	$posts = $reddit->GetSubredditPosts($key);
	
	foreach ($posts[data]->children as $post)
	{
		$action = new Action($post, $reddit, $data_connection, $value);
		$action->FindMatches($locations_regex);
		$action->PerformAction();
	}
}

// Handle username mentions.

$mention = new MentionAction($post, $reddit, $data_connection, $value);
$mention->PerformAction();
