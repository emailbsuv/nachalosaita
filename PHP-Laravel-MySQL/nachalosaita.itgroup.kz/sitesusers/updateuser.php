<?php
require_once('db.php');
if ($result = mysqli_query($link, "SELECT * FROM sitesusers WHERE cookies='".$_POST["cookies"]."'")) {
	$b=mysqli_num_rows($result);
	if($b>0){
		$r1 = mysqli_fetch_assoc($result);
		$userdata = '';
		$dtime = date("Y-m-d H:i:s");
		if($_POST["watch"]!=$r1["watch"]){$userdata .= "pageviews=".($r1["pageviews"]+1).", ";$userdata .= "watch='".$_POST["watch"]."', ";}
		if((strtotime($dtime)-strtotime($r1["lastvisittime"]))>3600)$userdata .= "visits=".($r1["visits"]+1).", ";
		//if((int)($_POST["usrtyping"])>0)$userdata .= "usrtyping=1, ";else $userdata .= "usrtyping=0, ";
		$userdata .= "onsitetime=".($r1["onsitetime"]+1).", ";
		$userdata .= "lastvisittime='".$dtime."'";
		mysqli_query($link, "UPDATE sitesusers SET ".$userdata." WHERE cookies='".$_POST["cookies"]."'");
		
		$msgs = array();$json = array();
		 $_POST["lastopmsgtime"] = date("Y-m-d H:i:s",(strtotime ($_POST["lastopmsgtime"])+1));
		if(strtotime($_POST["lastopmsgtime"])<strtotime($r1["lastopmsgtime"])){
			$r5 = mysqli_query($link, "SELECT usersopsmsgs.*, operators.name as opname FROM usersopsmsgs LEFT JOIN operators ON usersopsmsgs.opid=operators.id WHERE usersopsmsgs.userid=".$r1["id"]." AND usersopsmsgs.toop=0 AND usersopsmsgs.dtime BETWEEN '".date("Y-m-d H:i:s",strtotime($_POST["lastopmsgtime"]))."' AND '".$r1["lastopmsgtime"]."' ORDER BY usersopsmsgs.id ASC");
			while($r6 = mysqli_fetch_assoc($r5)){
				array_push($msgs,array("dtime"=>$r6["dtime"],"msg"=>"<b>".$r6["opname"]."</b><br>".$r6["msg"],"toop"=>$r6["toop"]));
			}
		}
		array_push($json,$msgs);
		$r5 = mysqli_query($link, "SELECT name,jpgname,position FROM operators WHERE id='".$r1["opid"]."'");
		$r6 = mysqli_fetch_assoc($r5);
		$r7 = mysqli_query($link, "SELECT DISTINCT operators.id FROM opsites LEFT JOIN operators ON opsites.opid=operators.id WHERE opsites.site='".$r1["urlsite"]."' AND  operators.lastvisitdtime>'".date("Y-m-d H:i:s",strtotime ("-10 seconds"))."'");
		$r8 = mysqli_num_rows($r7); $statusop="offline";if($r8>0)$statusop="online";
		array_push($json,array("lastopmsgtime"=>$r1["lastopmsgtime"],"optyping"=>$r1["optyping"],"name"=>$r6["name"],"jpgname"=>$r6["jpgname"],"oppos"=>$r6["position"],"opid"=>$r1["opid"],"operators"=>$statusop));
		
		//$f=fopen('tmp.txt','w');fwrite($f,print_r(json_encode($json),true));flose($f);
		echo json_encode($json);
	}
    mysqli_free_result($result);
}

mysqli_close($link);
?>