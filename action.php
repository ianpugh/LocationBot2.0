<?php

require_once('tracking.php');

class Action
{
	public $title;
	public $body;
	public $url;
	public $author;
	public $subreddit;
	public $thing_id;
	
	public $match_collection = array();
	
	private $reddit;
	private $reply = false;
	private $db;
	private $id;
	private $subreddid_rec_id;

	private $message = <<<STR
*I am a bot whose sole purpose is to improve the timeliness and accuracy of responses in this subreddit.*\n\n
---\r\n
**It appears you forgot to include your location in the title or body of your post.**\n\n
**Please update the original post to include this information.**\n\n
***Do NOT delete this post - Instead, simply edit the post with the requested information.*.**\n\n
---\r\n
[Report Inaccuracies Here](https://www.reddit.com/r/LocationBot/) | [GitHub] (https://github.com/ianpugh/LocationBot2.0) | [Author](https://reddit.com/u/ianp) | LocationBot v{version}\n\n
---\r\n
Original Post:\r\n
Author: /u/{author}\r\n
**{title}**
>{post}
STR;
		
	function  __construct ($post, $reddit, $db, $subreddit_rec_id)
	{
		$this->title = $db->real_escape_string($post->data->title);
		$this->body = $db->real_escape_string($post->data->selftext);
		$this->url = $db->real_escape_string($post->data->url);
		$this->author = $db->real_escape_string($post->data->author);
		$this->thing_id = $db->real_escape_string($post->data->name);
		$this->reddit = $reddit;
		$this->subreddit = $subreddit_rec_id;
		$this->subreddit_rec_id = $subreddit_rec_id;
			
		$this->db = $db;
	}
	
	public function FindMatches($regex)
	{
		$this->FindMatchesHelper($regex, $this->title);
		$this->FindMatchesHelper($regex, $this->body);
		
		return $this->match_collection;
}
	
	private function FindMatchesHelper($regex, $text)
	{
		$matches = array();
		
		preg_match_all($regex, $text, $matches, PREG_PATTERN_ORDER);
		
		if (sizeof($matches) > 0)
		{
			foreach ($matches[0] as $key => $value)
			{
				if (sizeof($value) > 0)
				{
					if ($value != "")
					{
						array_push($this->match_collection, $value);
					}
				}
			}
		}
	}
	
	function PerformAction()
	{
		// Determine if we have a record of this post.
		
		$query = "SELECT thing_id FROM Post WHERE thing_id='{$this->thing_id}'";
		$result = $this->db->query($query);
		
		if ($result->num_rows == 0)
		{			
			$query = "INSERT INTO Post (subreddit_rec_id, thing_id, author, body, title, url)" .
					 "VALUES" .
					 "({$this->subreddit_rec_id}, '{$this->thing_id}', '{$this->author}', '{$this->body}', '{$this->title}', '{$this->url}')";
			
			$this->db->query($query);
			$this->id = $this->db->insert_id;
			$this->reply = true;
		}
		
		// Did we store this post and are there any matches? If so, let's update the database with what we've found.
		
		if ($this->reply && sizeof($this->match_collection) > 0)
		{
			

			foreach ($this->match_collection as $key => $value)
			{
				$query = "INSERT INTO LocationMatch (Post_rec_id, name) VALUES ({$this->id}, '{$value}')";
				$this->db->query($query);
			}
			
			$query = rtrim($query, ',');
		}
		
		// Do we need to reply?

		if ($this->reply && sizeof($this->match_collection) == 0)
		{
			$post = str_replace("{author}", $this->author, $this->message);
			$post = str_replace("{version}", VERSION, $post);
						
			$post = str_replace("{title}", str_replace("\\n", "\n> ", str_replace('\"', '"', str_replace("\\'", "'", $this->title))), $post);
			
			$post = str_replace("{post}", str_replace("\\n", "\n> ", str_replace('\"', '"', str_replace("\\'", "'", $this->body))), $post);
			
			// $this->reddit->Post($this->thing_id, $post);
			
			$query = "INSERT INTO Reply (Post_rec_id) VALUES ('{$this->id}')";
			$this->db->query($query);
			
			CreateActionTrackingRecord ($this->db, $this->thing_id, "Action", "NoLocationFound", $this->author);
		}
	}
}

?>
