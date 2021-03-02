<?php
require_once('db.php');

if ($_POST["cookies"]!="0"){
	if ($result = mysqli_query($link, "SELECT * FROM operators WHERE cookies='".$_POST["cookies"]."'")) {
		$b=mysqli_num_rows($result);
		if($b>0) 
		{
			$r6 = mysqli_fetch_assoc($result);
			$mainarray = array();
			$r2 = mysqli_query($link, "SELECT * FROM opsites WHERE opid=".$r6["id"]." ORDER BY id ASC");
			while($r3 = mysqli_fetch_assoc($r2)){
				$departments = array();
				$r21 = mysqli_query($link, "SELECT * FROM sitesdepartment WHERE name='".$r3["site"]."' ORDER BY id ASC");
				while($r31 = mysqli_fetch_assoc($r21))array_push($departments,array("department"=>$r31["department"]));
				array_push($mainarray,array("id"=>$r3["id"],"site"=>$r3["site"],"department"=>($departments)));
			}
			mysqli_query($link, "UPDATE operators SET status='В сети', lastvisitdtime='".date("Y-m-d H:i:s")."' WHERE cookies='".$_POST["cookies"]."'");
			echo "{\"sites\" :".myjson_encode($mainarray).
			  myjson_encode2(array("name"=>$r6["name"],"jpgname"=>$r6["jpgname"],"id"=>$r6["id"],"cookies"=>$_POST["cookies"]))."}";
			mysqli_free_result($result);
			mysqli_free_result($r6);mysqli_free_result($r3);
		}else{
			echo "{\"sites\" :".'""'.myjson_encode2(array("cookies"=>"0"))."}";
		}
	}
} else
{
	if ($result = mysqli_query($link, "SELECT * FROM operators WHERE login='".$_POST["login"]."' AND password='".$_POST["password"]."'")) {
		$b=mysqli_num_rows($result);
		if($b>0) 
		{ 
			$r6 = mysqli_fetch_assoc($result);
			$r4=1;$cookie = '';
			while($r4>0){
				$cookie = randomCookie();
				$r3 = mysqli_query($link, "SELECT id FROM operators WHERE cookies='".$cookie."'");
				$r4 = mysqli_num_rows($r3);	
			}			
			mysqli_query($link, "UPDATE operators SET cookies='".$cookie."' WHERE login='".$_POST["login"]."' AND password='".$_POST["password"]."'");
			mysqli_query($link, "UPDATE operators SET status='В сети', lastvisitdtime='".date("Y-m-d H:i:s")."' WHERE login='".$_POST["login"]."' AND password='".$_POST["password"]."'");

			$mainarray = array();
			$r2 = mysqli_query($link, "SELECT * FROM opsites WHERE opid=".$r6["id"]." ORDER BY id ASC");
			while($r3 = mysqli_fetch_assoc($r2)){
				$departments = array();
				$r21 = mysqli_query($link, "SELECT * FROM sitesdepartment WHERE name='".$r3["site"]."' ORDER BY id ASC");
				while($r31 = mysqli_fetch_assoc($r21))array_push($departments,array("department"=>$r31["department"]));
				array_push($mainarray,array("id"=>$r3["id"],"site"=>$r3["site"],"department"=>($departments)));
			}
			echo "{\"sites\" :".myjson_encode($mainarray).
			  myjson_encode2(array("name"=>$r6["name"],"jpgname"=>$r6["jpgname"],"id"=>$r6["id"],"cookies"=>$cookie))."}";
			mysqli_free_result($result);
			mysqli_free_result($r6);mysqli_free_result($r3);
		}else{
			echo myjson_encode1(array("cookies"=>"0"));
		}
		//mysqli_free_result($result);
	}	
}
mysqli_close($link);
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

?>