<?php
require_once('db.php');
if ($_POST["cookies"]!="0"){
	if ($result = mysqli_query($link, "SELECT id FROM operators WHERE cookies='".$_POST["cookies"]."'")) {
		$b=mysqli_num_rows($result);
		if($b>0) 
		{
			$r6 = mysqli_fetch_assoc($result);
			mysqli_query($link, "UPDATE sitesusers SET usrtyping='".$_POST["usrtyping"]."' WHERE id=".$r6["id"]);
			
			$r2 = mysqli_query($link, "SELECT watch,onsitetime,pageviews,visits,usrtyping FROM sitesusers WHERE id=".$_POST["userid"]);
			$usersmsgs = array();
			while($r3 = mysqli_fetch_assoc($r2)){
				array_push($usersmsgs,array("watch"=>$r3["watch"],"onsitetime"=>mytime($r3["onsitetime"]),"pageviews"=>$r3["pageviews"],"visits"=>$r3["visits"],"usrtyping"=>$r3["usrtyping"]));
			}
			
			echo "{\"usertyping\" :".myjson_encode($usersmsgs)."}";
			mysqli_free_result($r6);
			mysqli_free_result($result);
		}
	}
}
function mytime($time1){
	$tmp="";
	$time = new DateTime('@'.$time1);
	$h = $time->format('H')+0;$i = $time->format('i')+0;$s = $time->format('s')+0;
	if($h>0)$tmp.=$h."час. ";if($i>0)$tmp.=$i."мин. ";if($s>0)$tmp.=$s."сек.";
	return $tmp;
}

?>