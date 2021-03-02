<?php
require_once('db.php');
if ($_POST["cookies"]!="0"){
	$dtime = date("Y-m-d H:i:s");
	if ($result = mysqli_query($link, "SELECT id FROM operators WHERE cookies='".$_POST["cookies"]."'")) {
		$b=mysqli_num_rows($result);
		if($b>0) 
		{
			$r6 = mysqli_fetch_assoc($result);
			mysqli_query($link, "UPDATE sitesusers SET redirectopid='".$_POST["opid"]."' WHERE id='".$_POST["userid"]."'");
			//mysqli_query($link, "UPDATE usersopsmsgs SET status=1 WHERE userid='".$_POST["userid"]."' AND opid='".$r6["id"]."'");
			
			mysqli_free_result($result);
			mysqli_free_result($r6);
		}
	}

}

?>