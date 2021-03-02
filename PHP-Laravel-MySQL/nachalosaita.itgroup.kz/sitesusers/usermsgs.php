<?php
require_once('db.php');
if ($result = mysqli_query($link, "SELECT * FROM sitesusers WHERE cookies='".$_POST["cookies"]."'")) {
	$b=mysqli_num_rows($result);
	if($b>0) 
	{
		$r1 = mysqli_fetch_assoc($result);
		$userdata = '';
		$dtime = date("Y-m-d H:i:s");
		if($_POST["watch"]!=$r1["watch"]){$userdata .= "pageviews=".($r1["pageviews"]+1).", ";$userdata .= "watch='".$_POST["watch"]."', ";}
		if((strtotime($dtime)-strtotime($r1["lastvisittime"]))>3600)$userdata .= "visits=".($r1["visits"]+1).", ";
		$userdata .= "onsitetime=".($r1["onsitetime"]+1).", ";
		$userdata .= "lastvisittime='".$dtime."'";
		mysqli_query($link, "UPDATE sitesusers SET ".$userdata." WHERE cookies='".$_POST["cookies"]."'");
		
		
		$msgs = array();$json = array();

		$r2 = mysqli_query($link, "SELECT * FROM usersopsmsgs WHERE userid=".$r1["id"]." ORDER BY dtime ASC");
		while($r6 = mysqli_fetch_assoc($r2)){
			array_push($msgs,array("dtime"=>$r6["dtime"],"msg"=>$r6["msg"],"toop"=>$r6["toop"]));
		}
		array_push($json,$msgs);
		array_push($json,array("lastopmsgtime"=>$r1["lastopmsgtime"], "cookies"=>$_POST["cookies"]));
		echo json_encode($json);
		
		mysqli_free_result($result);
		mysqli_free_result($r1);
	}else{
		$r4=1;$cookie = '';
		while($r4>0){
			$cookie = randomCookie();
			$r3 = mysqli_query($link, "SELECT id FROM sitesusers WHERE cookies='".$cookie."'");
			$r4 = mysqli_num_rows($r3);	
		}
		$r1 = mysqli_query($link, "SELECT max( id ) as mid FROM sitesusers");
		$r2 = mysqli_fetch_assoc($r1);$mid=$r2["mid"]+1;
		$lastopmsgtime = $lastmsgtime = date("Y-m-d H:i:s");
		mysqli_query($link, "INSERT INTO sitesusers VALUES (".$mid.",'','','','','".$_SERVER['REMOTE_ADDR']."','".$_POST["refferer"]."','".$_POST["watch"]."','".$_POST["urlsite"]."',1,1,1,0,'".$cookie."','".date("Y-m-d H:i:s")."','".$lastmsgtime."','".$lastopmsgtime."',0,0)");
		$msgs = array();$json = array();
		array_push($json,$msgs);
		array_push($json,array("lastopmsgtime"=>$lastopmsgtime, "cookies"=>$cookie));
		echo json_encode($json);
		mysqli_free_result($r1);
	}
}
function randomCookie() {
    $alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    $cookie = array();
    $alphaLength = strlen($alphabet) - 1;
    for ($i = 0; $i < 10; $i++) {
        $n = rand(0, $alphaLength);
        $cookie[] = $alphabet[$n];
    }
    return implode($cookie);
}
mysqli_close($link);
?>