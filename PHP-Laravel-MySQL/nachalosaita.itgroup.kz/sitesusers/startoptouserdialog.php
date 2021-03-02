<?php
require_once('db.php');
if ($_POST["cookies"]!="0"){
	if ($result = mysqli_query($link, "SELECT id FROM operators WHERE cookies='".$_POST["cookies"]."'")) {
		$b=mysqli_num_rows($result);
		if($b>0) 
		{
			$r6 = mysqli_fetch_assoc($result);
			mysqli_query($link, "UPDATE sitesusers SET opid='".$r6["id"]."' WHERE id=".$_POST["userid"]."");
			mysqli_free_result($result);
			mysqli_free_result($r6);
		}
	}
	$dialogs = array();
	$r4 = mysqli_query($link, "SELECT usersopsmsgs.*, operators.name as opname FROM usersopsmsgs LEFT JOIN operators ON operators.id=usersopsmsgs.opid WHERE usersopsmsgs.userid=".$_POST["userid"]." ORDER BY usersopsmsgs.id ASC");
	$r2 = mysqli_query($link, "SELECT name FROM sitesusers WHERE id=".$_POST["userid"]."");
	$r3 = mysqli_fetch_assoc($r2);
	while($r5 = mysqli_fetch_assoc($r4)){
		$name = $r3["name"]; if($r5["toop"]=="0")$name = $r5["opname"]; 
		$msg = str_replace('"',"`",$r5["msg"]);$msg = str_replace('"',"`",$msg);
		array_push($dialogs,array("msg"=>"<b>".$name."</b><br>".$msg,"dtime"=>$r5["dtime"],"toop"=>$r5["toop"]));
	}
	echo "{\"dialogs\" :".myjson_encode($dialogs)."}";
	
	mysqli_free_result($r4);mysqli_free_result($r3);mysqli_free_result($r5);mysqli_free_result($r2);
}

?>