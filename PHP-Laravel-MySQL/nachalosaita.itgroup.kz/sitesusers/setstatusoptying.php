<?php
require_once('db.php');
if ($_POST["cookies"]!="0"){
	if ($result = mysqli_query($link, "SELECT id FROM operators WHERE cookies='".$_POST["cookies"]."'")) {
		$b=mysqli_num_rows($result);
		if($b>0) 
		{
			mysqli_query($link, "UPDATE sitesusers SET optyping='".$_POST["optyping"]."' WHERE id=".$_POST["userid"]."");
			mysqli_free_result($result);
		}
	}
}

?>