<?php
header ("Access-Control-Allow-Origin: *");
//$link = mysqli_connect("127.0.0.1", "nacha_base", "7?24ohoW", "nachalosaita_base");
$link = mysqli_connect("127.0.0.1", "phpmyadmin", "123321", "nachalosaita_base");
mysqli_set_charset($link, "utf8");
function myjson_encode($value){
	$return = "";
	if(is_array($value)){
	    foreach ($value as $key1 => $value1) {
			$a1 = array_keys($value1);$a2 = array_values($value1);
			$return .= '{';$i3=0;
			foreach ($a2 as $key2 => $value2) {
				if(!is_array($value2))$return .= '"'.$a1[$i3].'":"'.$value2.'",';
				else
				$return .= '"'.$a1[$i3].'":'.myjson_encode($value2).',';
				$i3++;
			}
			$return = substr($return,0,-1);
			$return .= '},';
		}
		$return = substr($return,0,-1);
	}
	return 	'['.$return.']';
}
function myjson_encode1($value){
	$return = "";
	if(is_array($value)){
			$a1 = array_keys($value);$a2 = array_values($value);
			$return .= '{';$i3=0;
			foreach ($a2 as $key2 => $value2) {
				if(!is_array($value2))$return .= '"'.$a1[$i3].'":"'.$value2.'",';
				else
				$return .= '"'.myjson_encode($value2).'",';
				$i3++;
			}
			$return = substr($return,0,-1);
			$return .= '},';
		
		$return = substr($return,0,-1);
	}
	return 	$return;
}
function myjson_encode2($value){
	$return = "";
	if(is_array($value)){
			$a1 = array_keys($value);$a2 = array_values($value);
			$return .= ',';$i3=0;
			foreach ($a2 as $key2 => $value2) {
				$return .= '"'.$a1[$i3].'":"'.$value2.'",';
				$i3++;
			}
			$return = substr($return,0,-1);
	}
return 	$return;
}
?>