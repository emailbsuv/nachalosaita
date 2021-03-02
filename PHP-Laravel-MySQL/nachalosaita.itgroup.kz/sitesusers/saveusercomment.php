<?php
require_once('db.php');
if ($_POST["cookies"]!="0"){
	if ($result = mysqli_query($link, "SELECT id FROM operators WHERE cookies='".$_POST["cookies"]."'")) {
		$b=mysqli_num_rows($result);
		if($b>0) 
		{
			mysqli_query($link, "UPDATE sitesusers SET name='".$_POST["name"]."',phone='".$_POST["phone"]."',email='".$_POST["email"]."',comment='".$_POST["comment"]."' WHERE id=".$_POST["userid"]."");
			mysqli_free_result($result);
		}
	}
}

?>