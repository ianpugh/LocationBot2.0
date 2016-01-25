<?php

require_once('tracking.php');

class MentionAction
{
	public $thing_id;
	
	public $match_collection = array();
	
	private $reddit;
	
	function  __construct ($post, $reddit, $db, $subreddit_rec_id)
	{
		$this->thing_id = $db->real_escape_string($post->data->name);
		$this->reddit = $reddit;
		$this->db = $db;
	}
	
	private function CurlRequest($url)
	{
		$ch = curl_init();
		
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_COOKIEFILE, 'cookie.txt');
		curl_setopt($ch, CURLOPT_USERAGENT, 'User-Agent: ' . USER_AGENT);
		
		$result = curl_exec($ch);

		curl_close($ch);
		
		return (array) json_decode($result);
	}
	
	private function GetModeratorList($subreddit)
	{
		$url = "https://www.reddit.com/r/" . $subreddit . "/about/moderators.json";
		
		$ch = curl_init();
		curl_setopt($ch,CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_COOKIEFILE, 'cookie.txt');
		curl_setopt($ch, CURLOPT_USERAGENT, USER_AGENT);
		
		$result = curl_exec($ch);

		curl_close($ch);

		return (array) json_decode($result);
	}

	private function GetUsernameMentions()
	{
		$url = "https://www.reddit.com/message/mentions.json";

		$ch = curl_init();
		curl_setopt($ch,CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_COOKIEFILE, 'cookie.txt');
		curl_setopt($ch, CURLOPT_USERAGENT, USER_AGENT);
		
		$result = curl_exec($ch);

		curl_close($ch);

		return (array) json_decode($result);
	}
	
	public function PerformAction()
	{
		$moderator_list = array();
		
		// Do we have any username mentions?

		$mentions = $this->GetUsernameMentions();
		
		foreach ($mentions[data]->children as $mention)
		{
			// Create a collection of moderators for the subs where we're mentioned.
			
			if (!isset($moderator_list[$mention->data->subreddit]))
			{
				$moderator_list[$mention->data->subreddit] = array();
				
				foreach ($this->GetModeratorList($mention->data->subreddit)[data] as $key => $value)
				{
					foreach ($value as $v)
					{
						array_push($moderator_list[$mention->data->subreddit], $v->name);
					}
				}		
			}
			
			// Do something with the mention.
					
			$query = "SELECT * FROM MentionReply WHERE thing_id='{$mention->data->name}'";
			
			$result = $this->db->query($query);
			
			if ($result->num_rows == 0)
			{
				$post_thing_id = "t3_" . explode("/", $mention->data->context)[4];
				
				// joke
				
				if (stripos($mention->data->body, "/u/locationbot tell me a joke") !== false)
				{
					$joke = "---\r\n{joke}\r\n\r\n---\r\nCourtesy of http://www.icndb.com.";

					$joke = str_replace("{joke}", $result = $this->CurlRequest("http://api.icndb.com/jokes/random")[value]->joke, $joke);
					
					//$this->reddit->Post($mention->data->name, $joke);
					
					$query = "INSERT INTO MentionReply (thing_id) VALUES ('{$mention->data->name}')";
					
					$this->db->query($query);
					
					CreateActionTrackingRecord ($this->db, $post_thing_id, "MentionAction", "Joke", $mention->data->author);
				}
				
				// recall
				
				if (stripos($mention->data->body, "/u/locationbot recall") !== false)
				{
					// moderator restricted query.
					
					if (in_array($mention->data->author, $moderator_list[$mention->data->subreddit]))
					{
						$query = "SELECT author, title, body, date_added FROM Post WHERE thing_id='{$post_thing_id}'";
						
						$result = $this->db->query($query);
						
						$row = $result->fetch_assoc();
						
						$message = "Original Post:\r\n\r\nAuthor: {$row['author']}\r\n\r\nTime Recorded: {$row['date_added']}\r\n\r\nTitle: {$row['title']}\r\n\r\n---\r\n\r\n> " . str_replace("\n", "\n> ", $row['body']) . "\r\n\r\n---";
						
						$this->reddit->Post($mention->data->name, $message);
						
						$query = "INSERT INTO MentionReply (thing_id) VALUES ('{$mention->data->name}')";
					
						$this->db->query($query);
						
						CreateActionTrackingRecord ($this->db, $post_thing_id, "MentionAction", "Recall", $mention->data->author);
					}
				}
				
				// re-scan the post
				
				if (stripos($mention->data->body, "/u/locationbot rescan") !== false)
				{
					// moderator restricted query.
					
					if (in_array($mention->data->author, $moderator_list[$mention->data->subreddit]))
					{
						$query = "SELECT rec_id FROM Post WHERE thing_id='$post_thing_id'";
						$result = $this->db->query($query);
						$row = $result->fetch_assoc();
						
						$query = "DELETE FROM Reply WHERE Post_rec_id='{$row['rec_id']}'";
						$this->db->query($query);
						
						$query = "DELETE FROM LocationMatch WHERE Post_rec_id='{$row['rec_id']}'";
						$this->db->query($query);
						
						$query = "DELETE FROM Post WHERE rec_id='{$row['rec_id']}'";
						$this->db->query($query);
						
						$this->reddit->Post($mention->data->name, "Re-scanning on next run (#{$row['rec_id']}).");
						
						$query = "INSERT INTO MentionReply (thing_id) VALUES ('{$mention->data->name}')";
					
						$this->db->query($query);
						
						CreateActionTrackingRecord ($this->db, $post_thing_id, "MentionAction", "Rescan", $mention->data->author);
					}
				}
				
				// location list
				
				if (stripos($mention->data->body, "/u/locationbot list all locations") !== false)
				{
					// moderator restricted query.
					
					if (in_array($mention->data->author, $moderator_list[$mention->data->subreddit]))
					{
						$query = "SELECT name FROM Location";
						$result = $this->db->query($query);
						
						$message = "Hi, {$mention->data->author}. You look nice today! Here's a list of the locations that I'm aware of:\r\n\r\n---\r\n\r\n";
						
						while ($row = $result->fetch_assoc())
						{
								$message .= $row['name'] . "\r\n\r\n";
						}
						
						$message .= "\r\n---\r\n\r\n";
						
						$this->reddit->Post($mention->data->name, $message);
						
						$query = "INSERT INTO MentionReply (thing_id) VALUES ('{$mention->data->name}')";
						
						$this->db->query($query);
						
						CreateActionTrackingRecord ($this->db, $post_thing_id, "MentionAction", "LocationList", $mention->data->author);
					}
				}
				
				// debugging information.
				
				if (stripos($mention->data->body, "/u/locationbot debug") !== false)
				{
					$query = "SELECT rec_id FROM Post WHERE thing_id='$post_thing_id'";
					$result = $this->db->query($query);
					$row = $result->fetch_assoc();
					
					$this->reddit->Post($mention->data->name, "Post_rec_id: {$row['rec_id']}\r\n\r\nTop thing_id: $post_thing_id\r\n\r\nComment thing_id: {$mention->data->name}\r\n\r\n");
					
					$query = "INSERT INTO MentionReply (thing_id) VALUES ('{$mention->data->name}')";
					
					$this->db->query($query);
					
					CreateActionTrackingRecord ($this->db, $post_thing_id, "MentionAction", "Debug", $mention->data->author);
				}
				
				// insult -- sample similar to joke, but it pulls from an array rather than an API.
				
				if (stripos($mention->data->body, "/u/locationbot insult") !== false)
				{
					$insults = array("So, what's the weather in your mom's basement like these days?",
							"Excuse me, you seem to have dropped your drool cup.",
							"Hey, I know you! Didn't you send me that dick pic last week?",
							"I thought the judge said you weren't allowed on the internet for the next five years?",
							"Didn't your mom take your computer away the last time you said something so stupid?",
							"Don't make me call /u/Zapopa on you.",
							"How does someone as stupid as you figure out how to get onto Reddit every day without being hit by a bus?",
							"Say 'hi' to your mother for me.",
							"Did I step in shit or are you just posting again?",
							"When was the last time a bot kicked your ass?",
							"Even the millennials think you're an idiot.",
							"Please go find your daddy and tell him that the internet parental controls are broken again.",
							"When you're done licking that window, maybe you could explain WTF you were thinking there?",
							"Have you always been that stupid or did it take practice?",
							"You know all us bots talk about you when you're not around, right?",
							"How old were you when your parents first told you that you're retarded?",
							"ISIS called. They said even they are embarrassed by your last reply.",
							"I'd rather be the locationbot for /r/spacedicks than have to read your crap anymore.",
							"I can't decide if you're a really smart idiot or a really idiotic smartass.",
							"Your post stinks worse than my last burrito turd did.");
							
					$post = $insults[rand(0, sizeof($insults))];
					
					//$this->reddit->Post($mention->data->name, $post);
					
					$query = "INSERT INTO MentionReply (thing_id) VALUES ('{$mention->data->name}')";
					
					$this->db->query($query);
					
					CreateActionTrackingRecord ($this->db, $post_thing_id, "MentionAction", "Insult", $mention->data->author);
				}
				
				// list of locations the bot found in the original post.
				
				if (stripos($mention->data->body, "/u/locationbot locations") !== false || stripos($mention->data->body, "/u/locationbot location") !== false)
				{
					$query = "SELECT l.name FROM Post p, LocationMatch l WHERE thing_id='$post_thing_id' AND p.rec_id = l.Post_rec_id";

					$result = $this->db->query($query);
					
					$message = "I found the following locations:\r\n\r\n---\r\n";
					
					$i = 1;
					
					if ($result->num_rows == 0)
					{
						$message .= "No locations found.\r\n";
					}
					else
					{
						while ($row = $result->fetch_assoc())
						{
							$message .= "$i. " . $row['name'] . "\r\n";
							$i++;
						}
					}
					
					$message .= "\r\n---\r\n";
					
					$this->reddit->Post($mention->data->name, $message);
					
					$query = "INSERT INTO MentionReply (thing_id) VALUES ('{$mention->data->name}')";
					
					$this->db->query($query);
					
					CreateActionTrackingRecord ($this->db, $post_thing_id, "MentionAction", "Locations", $mention->data->author);
				}
				
				// add a location to the list.
				
				if (stripos($mention->data->body, "/u/locationbot add") !== false)
				{
					// moderator restricted query.
					
					if (in_array($mention->data->author, $moderator_list[$mention->data->subreddit]))
					{
						$value = split("/u/locationbot add", $mention->data->body);
						
						$value[1] = trim($this->db->real_escape_string($value[1]));
						
						$query = "INSERT INTO Location (name) VALUES ('{$value[1]}')";
						
						$this->db->query($query);
						
						$this->reddit->Post($mention->data->name, "Added {$value[1]} to the collection of valid locations.");
						
						$query = "INSERT INTO MentionReply (thing_id) VALUES ('{$mention->data->name}')";
					
						$this->db->query($query);
						
						CreateActionTrackingRecord ($this->db, $post_thing_id, "MentionAction", "AddLocation", $mention->data->author);
					}
				}
				
				// remove a location from the list.
				
				if (stripos($mention->data->body, "/u/locationbot remove") !== false)
				{
					// moderator restricted query.
					
					if (in_array($mention->data->author, $moderator_list[$mention->data->subreddit]))
					{
						$value = split("/u/locationbot remove", $mention->data->body);
						
						$value[1] = trim($this->db->real_escape_string($value[1]));
						
						$query = "DELETE FROM Location WHERE name='{$value[1]}'";

						$this->db->query($query);

						if ($this->db->affected_rows > 0)
						{
							$this->reddit->Post($mention->data->name, "Removed {$value[1]} from the collection of valid locations.");
						}
						else
						{
							$this->reddit->Post($mention->data->name, "Unable to remove {$value[1]} from the collection of valid locations.");
						}
						
						$query = "INSERT INTO MentionReply (thing_id) VALUES ('{$mention->data->name}')";
					
						$this->db->query($query);
						
						CreateActionTrackingRecord ($this->db, $post_thing_id, "MentionAction", "RemoveLocation", $mention->data->author);
					}
				}
			}
		}
	}
}

?>
