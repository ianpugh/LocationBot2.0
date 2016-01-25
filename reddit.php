<?php

/*
 *
 * Creates an authenticated Reddit session for a given user.
 *
 */
	 
class Reddit
{
	private $username = "";
	private $password = "";
	private $modhash = "";
	
	function __construct ($username, $password)
	{
			$this->username = $username;
			$this->password = $password;
	}
	
	private function CurlRequest($url, $fields = "", $fields_string = "")
	{
		$ch = curl_init();
		
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_COOKIEFILE, 'cookie.txt');
		curl_setopt($ch, CURLOPT_USERAGENT, 'User-Agent: ' . USER_AGENT);
		
		if ($fields != "" || $fields_string != "")
		{
			curl_setopt($ch, CURLOPT_POST, count($fields));
			curl_setopt($ch, CURLOPT_POSTFIELDS, $fields_string);
		}
		
		$result = curl_exec($ch);

		curl_close($ch);
		
		return (array) json_decode($result);
	}
	
	public function Login ()
	{				
		$url = "https://ssl.reddit.com/api/login";
		

		$fields = array("api_type" => "json", "passwd" => $this->password, "rem" => "True", "user" => $this->username);

		foreach($fields as $key => $value) 
		{
			$fields_string .= "$key=" . urlencode($value) . "&";
		}

		rtrim($fields_string, '&');

		$ch = curl_init();
		
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_POST, count($fields));
		curl_setopt($ch, CURLOPT_POSTFIELDS, $fields_string);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_COOKIEJAR, 'cookie.txt');
		curl_setopt($ch, CURLOPT_USERAGENT, 'User-Agent: ' . USER_AGENT);

		$json_data = (array) json_decode(curl_exec($ch));

		curl_close($ch);

		@$this->modhash = $json_data['json']->data->modhash;
		
		return sizeof($json_data['json']->errors) == 0;
	}
	
	public function Post ($post_id, $message)
	{
		$url = "https://www.reddit.com/api/comment";

		$fields = array("api_type" => "json", "text" => $message, "thing_id" => $post_id, "uh" => $this->modhash);

		$fields_string = "";
		
		foreach($fields as $key => $value)
		{
			$fields_string .= "$key=" . urlencode($value) . "&";
		}

		rtrim($fields_string, '&');

		$json_data = $this->CurlRequest ($url, $fields, $fields_string);
		
		return sizeof($json_decode['data']->errors) == 0;
	}
	
	public function GetSubredditPosts($subreddit)
	{
		$url = "https://www.reddit.com/r/$subreddit/.json";
		
		$value = $this->CurlRequest ($url);
		
		return $value;
	}

	function GetUsernameMentions()
	{
		$url = "https://www.reddit.com/message/mentions.json";
	
		$value = $this->CurlRequest ($url);
		
		return $value;
	}

	function GetModeratorList($subreddit)
	{
		$url = "https://www.reddit.com/r/" . $subreddit . "/about/moderators.json";
		
		$value = $this->CurlRequest ($url);
		
		return $value;
	}
}

?>
