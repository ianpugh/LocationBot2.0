<?php

require_once ('credentials.php');

class Data
{
	/**
	*
	* Gets a database connection from credentials supplied in DB_HOST, DB_USERNAME and DB_PASSWORD constants.
	*
	* @return	array
	*
	*/
	public static function GetConnection()
	{
		$db =  new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD);
		$db->select_db(DB_NAME);
		
		return $db;
	}
}

?>
