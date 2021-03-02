<?php
require_once('db.php');
if ($_POST["cookies"]!="0"){
	if ($result = mysqli_query($link, "SELECT id FROM operators WHERE cookies='".$_POST["cookies"]."'")) {
		$b=mysqli_num_rows($result);
		if($b>0) 
		{
			mysqli_query($link, "DELETE FROM opsites WHERE id='".$_POST["siteid"]."'");	
			mysqli_free_result($result);
		}
	}

}

?>