<?php

require_once('tracking.php');

class MonitorAction
{
	private $reddit;
	
	private $subreddit;
	
	function  __construct ($reddit, $db, $subreddit)
	{
		$this->reddit = $reddit;
		$this->db = $db;
		$thid->subreddit = $subreddit;
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
	
	private function GetReportsLog($subreddit)
	{
		$url = "https://www.reddit.com/r/$subreddit/about/reports/.json";
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
		
		// Do we have any info in the modlog?
		$reports = $this->GetReportsLog($subreddit);
		
		foreach ($reports[data]->children as $report)
		{
			$author = $report->author;
			$url = $report->url;
			$reports = array();
			
			foreach ($report->data->user_reports as $reason)
			{
				$query = "INSERT INTO PostReport (link_id, link_author, reason, ,url, body) VALUES ('{$report->data->name}','{$report->data->link_author}','{$reason}', '{$report->data->link_url}')";
				$this->db->query($query);
			}
		}
	}
}
?>
