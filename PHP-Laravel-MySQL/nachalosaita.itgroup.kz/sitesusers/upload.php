<?php
header ("Access-Control-Allow-Origin: *");
	
    if ( 0 < $_FILES['file']['error'] ) {
        echo 'Error: ' . $_FILES['file']['error'] . '<br>';
    }
    else {
		$filename = getNewFileName($_FILES['file']['name']);
        move_uploaded_file($_FILES['file']['tmp_name'], '../uploads/' . $filename);
		echo $filename;
    }
function getNewFileName($file){
	$files = scandir('../uploads');
	$newfilename = '';
	while ($newfilename == ''){
		foreach($files as $val)
		{
			$tmp = randomFileName().$file;
			if($val != $tmp)$newfilename = $tmp;
		}
	}
	return $newfilename;
}
function randomFileName() {
    $alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    $cookie = array();
    $alphaLength = strlen($alphabet) - 1;
    for ($i = 0; $i < 5; $i++) {
        $n = rand(0, $alphaLength);
        $cookie[] = $alphabet[$n];
    }
    return implode($cookie);
}
?>