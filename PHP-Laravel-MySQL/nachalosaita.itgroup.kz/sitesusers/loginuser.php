<?php
require_once('db.php');
if ($result = mysqli_query($link, "SELECT * FROM sitesusers WHERE cookies='".$_POST["cookies"]."'")) {
	$b=mysqli_num_rows($result);
	if($b>0) 
	{
		$r1 = mysqli_fetch_assoc($result);
		$userdata = '';$dtime = date("Y-m-d H:i:s");
		//if(strlen($_POST["opid"])>0)$userdata .= "opid='".$_POST["opid"]."', ";
		if(strlen($_POST["name"])>0)$userdata .= "name='".$_POST["name"]."', ";
		if(strlen($_POST["phone"])>0)$userdata .= "phone='".$_POST["phone"]."', ";
		if(strlen($_POST["email"])>0)$userdata .= "email='".$_POST["email"]."', ";
		if($_POST["watch"]!=$r1["watch"]){$userdata .= "pageviews=".($r1["pageviews"]+1).", ";$userdata .= "watch='".$_POST["watch"]."', ";}
		if((strtotime($dtime)-strtotime($r1["lastvisittime"]))>3600)$userdata .= "visits=".($r1["visits"]+1).", ";
		$userdata .= "onsitetime=".($r1["onsitetime"]+1);
		mysqli_query($link, "UPDATE sitesusers SET ".$userdata." WHERE cookies='".$_POST["cookies"]."'");

		if(strlen($_POST["msg"])>0){
			$r3 = mysqli_query($link, "SELECT max( id ) as mid FROM usersopsmsgs");
			$r4 = mysqli_fetch_assoc($r3);$mid=$r4["mid"]+1;mysqli_free_result($r3);
			mysqli_query($link, "INSERT INTO usersopsmsgs VALUES (".$mid.",".$r1["id"].",".$r1["opid"].",'".$_POST["msg"]."','".$dtime."',1,0)");
			mysqli_query($link, "UPDATE sitesusers SET lastmsgtime='".$dtime."' WHERE cookies='".$_POST["cookies"]."'");
		}
		
		$json = array();
		array_push($json,array("cookies"=>$_POST["cookies"]));
		echo json_encode($json);
		
		mysqli_free_result($result);
		mysqli_free_result($r1);
	}
}
?>