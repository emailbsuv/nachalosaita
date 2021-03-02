<?php
require_once('db.php');
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;
require 'vendor/autoload.php';
$mail = new PHPMailer(true);

if ($_POST["cookies"]!="0"){
	$dtime = date("Y-m-d H:i:s");
	if ($result = mysqli_query($link, "SELECT id,name,position,midmsgtime FROM operators WHERE cookies='".$_POST["cookies"]."'")) {
		$b=mysqli_num_rows($result);
		if($b>0) 
		{
			$r6 = mysqli_fetch_assoc($result);
			if(strlen($_POST["msg"])>0){
				$r7 = mysqli_query($link, "SELECT dtime FROM usersopsmsgs WHERE opid=".$r6["id"]." AND userid=".$_POST["userid"]." AND toop=1 ORDER BY id DESC LIMIT 1");$r8 = mysqli_fetch_assoc($r7);
				mysqli_query($link, "UPDATE operators SET midmsgtime='".(int)(((strtotime($dtime) - strtotime($r8["dtime"]))+$r6["midmsgtime"])/2)."' WHERE id='".$r6["id"]."'");
				$r3 = mysqli_query($link, "SELECT max( id ) as mid FROM usersopsmsgs");
				$r4 = mysqli_fetch_assoc($r3);$mid=$r4["mid"]+1;
				mysqli_query($link, "INSERT INTO usersopsmsgs VALUES (".$mid.",".$_POST["userid"].",".$r6["id"].",'".$_POST["msg"]."','".$dtime."',0,0)");
				mysqli_query($link, "UPDATE sitesusers SET lastopmsgtime='".$dtime."' WHERE id='".$_POST["userid"]."'");
				
				$r3 = mysqli_query($link, "SELECT lastvisittime,urlsite,name,email FROM sitesusers WHERE id='".$_POST["userid"]."'");
				$r4 = mysqli_fetch_assoc($r3);
				$now = strtotime(date("Y-m-d H:i:s"));
				$then = strtotime($r4["lastvisittime"]);	
				if((($now - $then)>20)&&($r4["name"]!='')){
					
					$mail->DKIM_domain = 'nachalosaita.itgroup.kz';
					$mail->DKIM_private = '/httpdocs/priv.key';
					$mail->DKIM_selector = 'phpmailer';
					$mail->DKIM_passphrase = '';
					$mail->DKIM_identity = 'noreply@nachalosaita.itgroup.kz';
					$mail->setFrom('noreply@nachalosaita.itgroup.kz', $r6["name"].', '.$r4["urlsite"]);
					$mail->addAddress($r4["email"], $r4["name"]);
					$mail->addReplyTo('noreply@nachalosaita.itgroup.kz', $r6["name"].', '.$r4["urlsite"]);
					// $mail->addAttachment('/tmp/image.jpg', 'new.jpg');
					$mail->isHTML(true);
					$mail->CharSet = 'UTF-8';
					$mail->Subject = 'Re: Чат на сайте '.$r4["urlsite"].' ['.rand(111111,999999).'-'.rand(11,99).']';
					$mail->Body    = $_POST["msg"].'<br><hr size="1">'.$r6["name"].' '.$r6["position"].' <br><br><img src="https://nachalosaita.itgroup.kz/img/l1.png" border="0">';
					$mail->AltBody = $_POST["msg"]."\r\n\r\n==================\r\n".$r6["name"].' '.$r6["position"]."\r\n\r\n Началосайта";
					$mail->send();					
					
				}
				
				mysqli_free_result($r3);mysqli_free_result($r4);
			}
			mysqli_free_result($result);
			mysqli_free_result($r6);
		}
	}

}

?>