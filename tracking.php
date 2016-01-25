<?php

function CreateActionTrackingRecord ($db, $thing_id, $type, $description, $username = "")
{
	$query = "INSERT INTO ActionTracking (thing_id, action_type, action_description, username) VALUES ('$thing_id', '$type', '$description', '$username')";
	$db->query($query);
}

?>
