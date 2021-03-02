<?php
require_once('db.php');

if ($_POST["cookies"]!="0"){
	if ($result = mysqli_query($link, "SELECT * FROM operators WHERE cookies='".$_POST["cookies"]."'")) {
		$b=mysqli_num_rows($result);
		if($b>0) 
		{
			$r6 = mysqli_fetch_assoc($result);
			mysqli_query($link, "UPDATE operators SET status='".$_POST["status"]."', lastvisitdtime='".date("Y-m-d H:i:s")."' WHERE cookies='".$_POST["cookies"]."'");
			mysqli_free_result($result);
			mysqli_free_result($r6);
		}
	}
}

?>