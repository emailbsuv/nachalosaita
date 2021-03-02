<?php
require_once('db.php');
//$_POST["cookies"]="tger2shPXx";
if ($_POST["cookies"]!="0"){
	if ($result = mysqli_query($link, "SELECT * FROM operators WHERE cookies='".$_POST["cookies"]."'")) {
		$b=mysqli_num_rows($result);
		if($b>0) 
		{
			$r6 = mysqli_fetch_assoc($result);
			mysqli_query($link, "UPDATE operators SET day7 = day7 + 1 WHERE id='".$r6["id"]."'");
			$operators = array();
			$r2 = mysqli_query($link, "SELECT DISTINCT opid FROM opsites WHERE site IN (select site from opsites where opid =".$r6["id"].") AND opid<>".$r6["id"]." ");
			while($r3 = mysqli_fetch_assoc($r2)){
				$opsites ='';$departments ='';$sitesdepartments =array();$sitesdepts =array();
				$r4 = mysqli_query($link, "SELECT site FROM opsites WHERE opid=".$r3["opid"]);
				while($r5 = mysqli_fetch_assoc($r4)){
					$opsites.= "'".$r5["site"]."',";
					$r41 = mysqli_query($link, "SELECT department FROM sitesdepartment WHERE name='".$r5["site"]."' AND opid='".$r3["opid"]."'");
					while($r51 = mysqli_fetch_assoc($r41))
						//if(!strpos($departments,"'".$r51["department"]."'"))
							//$departments.= "'".$r51["department"]."',";
						array_push($sitesdepartments,array("dept"=>$r51["department"]));
					array_push($sitesdepts,array("domain"=>$r5["site"],"depts"=>$sitesdepartments));
				}
				$r4 = mysqli_query($link, "SELECT * FROM operators WHERE id=".$r3["opid"]." AND lastvisitdtime>'".date("Y-m-d H:i:s",strtotime ("-50 seconds"))."'");
				if(mysqli_num_rows($r4)>0){
					$r5 = mysqli_fetch_assoc($r4);array_push($operators,array("id"=>$r5["id"],"name"=>$r5["name"],"jpgname"=>$r5["jpgname"],"status"=>$r5["status"],"sitesdepts"=>$sitesdepts));
				}
			  //array_push($operators,array(print_r($r3,true)));
			}

			$users = array();
			//$r2 = mysqli_query($link, "SELECT * FROM sitesusers WHERE urlsite IN (select site from opsites where opid =".$r6["id"].") AND  lastvisittime>'".date("Y-m-d H:i:s",strtotime ("-50 seconds"))."' AND opid<>".$r6["id"]." AND blocked=0 ORDER BY id DESC");
			$r2 = mysqli_query($link, "SELECT DISTINCT sitesusers.id, sitesusers.* FROM sitesusers LEFT JOIN usersopsmsgs ON (usersopsmsgs.userid=sitesusers.id) OR (sitesusers.lastvisittime>'".date("Y-m-d H:i:s",strtotime ("-10 seconds"))."') WHERE sitesusers.urlsite IN (select site from opsites where opid=".$r6["id"].") AND sitesusers.opid<>".$r6["id"]." AND usersopsmsgs.status<>1 AND sitesusers.blocked=0 ORDER BY sitesusers.id DESC");
			while($r3 = mysqli_fetch_assoc($r2)){
				$usersmsgs = array();$tmp="";
				if($r3["opid"]!='0') $tmp="opid=".$r3["opid"]." AND";
				$r4 = mysqli_query($link, "SELECT count( id ) as cnt FROM usersopsmsgs WHERE ".$tmp." userid=".$r3["id"]." AND status=0");
				$r5 = mysqli_fetch_assoc($r4);
				$r4 = mysqli_query($link, "SELECT name,jpgname FROM operators WHERE id=".$r3["opid"]);$r7 = mysqli_fetch_assoc($r4);
				
				array_push($users,array("id"=>$r3["id"],"name"=>$r3["name"],"phone"=>$r3["phone"],"email"=>$r3["email"],"comment"=>$r3["comment"],"ip"=>$r3["ip"],"refferer"=>$r3["refferer"],"watch"=>$r3["watch"],"urlsite"=>$r3["urlsite"],"onsitetime"=>mytime($r3["onsitetime"]),"pageviews"=>$r3["pageviews"],"visits"=>$r3["visits"],"dialogscnt"=>$r5["cnt"],"opname"=>$r7["name"],"opjpg"=>$r7["jpgname"],"lastmsgtime"=>$r3["lastmsgtime"],"lastvisittime"=>$r3["lastvisittime"]));
				
			  //array_push($users,array(print_r($r3,true)));
			}			
			
			
			$dialogs = array();$usersmsgs = array();
			$r2 = mysqli_query($link, "SELECT * FROM sitesusers WHERE urlsite IN (select site from opsites where opid =".$r6["id"].") AND lastvisittime>'".date("Y-m-d H:i:s",strtotime ("-50 seconds"))."'");
			$arr= json_decode( str_replace("=\r\n","",$_POST["usersmsgtime"]), true);
			//$f=fopen('tmp.txt','a');fwrite($f,print_r($_POST["usersmsgtime"],true));fclose($f);
			while($r3 = mysqli_fetch_assoc($r2)){
				$usersmsgs = array();
				$lastmsgtime =$r3["lastmsgtime"];$t=0;foreach($arr as $v)if($v["userid"]==$r3["id"]){$lastmsgtime =$v["lastmsgtime"];$t=1;}
				if(($r3["opid"]==$r6["id"])&&($t==1)){
					$r4 = mysqli_query($link, "SELECT  usersopsmsgs.*, operators.name as opname FROM usersopsmsgs LEFT JOIN operators ON usersopsmsgs.opid=operators.id WHERE usersopsmsgs.opid=".$r3["opid"]." AND usersopsmsgs.userid=".$r3["id"]." AND usersopsmsgs.toop=1 AND dtime>'".$lastmsgtime."' ORDER BY usersopsmsgs.id ASC");$r7=mysqli_num_rows($r4);if($r7<1)$r7='';
					while($r5=mysqli_fetch_assoc($r4)){
						$name = $r3["name"]; if($r5["toop"]=="0")$name = $r5["opname"]; 
						$msg = str_replace('"','`',$r5["msg"]);$msg = str_replace("'",'`',$msg);
						array_push($usersmsgs,array("msg"=>"<b>".$name."</b><br>".$msg,"dtime"=>$r5["dtime"]));$lastmsgtime=$r5["dtime"];}
				
					array_push($dialogs,array("id"=>$r3["id"],"newmsgcnt"=>$r7,"name"=>$r3["name"],"phone"=>$r3["phone"],"email"=>$r3["email"],"comment"=>$r3["comment"],"ip"=>$r3["ip"],"refferer"=>$r3["refferer"],"watch"=>$r3["watch"],"urlsite"=>$r3["urlsite"],"onsitetime"=>mytime($r3["onsitetime"]),"pageviews"=>$r3["pageviews"],"visits"=>$r3["visits"],"usrtyping"=>$r3["usrtyping"],"lastmsgtime"=>$lastmsgtime,"msgs"=>$usersmsgs));
				}
				//if(count($usersmsgs)>0){$f=fopen('tmp.txt','a');fwrite($f,print_r(myjson_encode($dialogs)."\r\n\r\n",true));fclose($f);}
				
			}

			$requestdialogs = array();$usersmsgs = array();$lastmsgtime="2000-01-01 00:00:00";
			$r2 = mysqli_query($link, "SELECT * FROM sitesusers WHERE redirectopid='".$r6["id"]."'");
			//$f=fopen('tmp.txt','a');fwrite($f,print_r($_POST["usersmsgtime"],true));fclose($f);
			while($r3 = mysqli_fetch_assoc($r2)){
				$usersmsgs = array();
				$r4 = mysqli_query($link, "SELECT usersopsmsgs.*, operators.name as opname FROM usersopsmsgs LEFT JOIN operators ON usersopsmsgs.opid=operators.id WHERE usersopsmsgs.userid=".$r3["id"]." ORDER BY usersopsmsgs.id ASC");$r7=mysqli_num_rows($r4);if($r7<1)$r7='';
				while($r5=mysqli_fetch_assoc($r4)){
					$name = $r3["name"]; if($r5["toop"]=="0")$name = $r5["opname"]; 
					$msg = str_replace('"','`',$r5["msg"]);$msg = str_replace("'",'`',$msg);
					array_push($usersmsgs,array("msg"=>"<b>".$name."</b><br>".$msg,"dtime"=>$r5["dtime"],"toop"=>$r5["toop"]));$lastmsgtime=$r5["dtime"];}
			
				array_push($requestdialogs,array("id"=>$r3["id"],"newmsgcnt"=>$r7,"name"=>$r3["name"],"phone"=>$r3["phone"],"email"=>$r3["email"],"comment"=>$r3["comment"],"ip"=>$r3["ip"],"refferer"=>$r3["refferer"],"watch"=>$r3["watch"],"urlsite"=>$r3["urlsite"],"onsitetime"=>mytime($r3["onsitetime"]),"pageviews"=>$r3["pageviews"],"visits"=>$r3["visits"],"usrtyping"=>$r3["usrtyping"],"lastmsgtime"=>$lastmsgtime,"msgs"=>$usersmsgs));
				mysqli_query($link, "UPDATE sitesusers SET opid='".$r6["id"]."',redirectopid='0' WHERE id='".$r3["id"]."'");
				//if(count($requestdialogs)>0){$f=fopen('tmp.txt','a');fwrite($f,print_r(myjson_encode($requestdialogs)."\r\n\r\n",true));fclose($f);}
			}
			
			
			
			mysqli_query($link, "UPDATE operators SET lastvisitdtime='".date("Y-m-d H:i:s")."' WHERE cookies='".$_POST["cookies"]."'");
			$a= "{\"ops\" :".myjson_encode($operators).", \"users\" :".myjson_encode($users).", \"dialogs\" :".myjson_encode($dialogs).", \"requestdialogs\" :".myjson_encode($requestdialogs).myjson_encode2(array("cookies"=>$_POST["cookies"]))."}";
			//$f=fopen('tmp.txt','a');fwrite($f,$a);fclose($f);
			echo $a;
			
			mysqli_free_result($result);
			mysqli_free_result($r6);mysqli_free_result($r3);mysqli_free_result($r4);mysqli_free_result($r5);
		}else{
			echo "{\"ops\" :".'""'.myjson_encode2(array("cookies"=>"0"))."}";
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