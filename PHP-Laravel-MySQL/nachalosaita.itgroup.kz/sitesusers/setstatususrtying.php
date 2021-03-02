<?php
require_once('db.php');
if ($_POST["cookies"]!="0"){
	if ($result = mysqli_query($link, "SELECT id,cookies FROM sitesusers WHERE cookies='".$_POST["cookies"]."'")) {
		$b=mysqli_num_rows($result);
		if($b>0) 
		{
			$r6 = mysqli_fetch_assoc($result);
			mysqli_query($link, "UPDATE sitesusers SET usrtyping='".$_POST["usrtyping"]."' WHERE id=".$r6["id"]);
			mysqli_free_result($r6);
			mysqli_free_result($result);
		}
	}
}

?> 