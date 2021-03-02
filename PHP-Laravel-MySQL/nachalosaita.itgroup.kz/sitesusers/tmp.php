<?php
/*
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;
require 'vendor/autoload.php';
$mail = new PHPMailer(true);

	$mail->DKIM_domain = 'nachalosaita.itgroup.kz';
	$mail->DKIM_private = '/httpdocs/priv.key';
	$mail->DKIM_selector = 'phpmailer';
	$mail->DKIM_passphrase = '';
	$mail->DKIM_identity = 'noreply@nachalosaita.itgroup.kz';
	$mail->setFrom('noreply@nachalosaita.itgroup.kz', 'Богдан, fpgamcu.tk');
	$mail->addAddress('emailbsuv@gmail.com', 'Bogdan Suvorov');
	$mail->addReplyTo('noreply@nachalosaita.itgroup.kz', 'Богдан, fpgamcu.tk');
	// $mail->addAttachment('/tmp/image.jpg', 'new.jpg');
	$mail->isHTML(true);
	$mail->CharSet = 'UTF-8';
	$mail->Subject = 'Re: Чат на сайте fpgamcu.tk ['.rand(111111,999999).'-'.rand(11,99).']';
	$mail->Body    = 'This is the HTML message body <b>Сообщение</b><br><hr size="1">Богдан Консультант <br><br><img src="https://nachalosaita.itgroup.kz/img/l1.png" border="0">';
	$mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
	$mail->send();
*/
	
/*$now = strtotime(date("Y-m-d H:i:s"));
$then = strtotime("2020-06-10 20:36:10");	
echo $now-$then;*/

$stack = array("Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс");
for($i=0;$i<date("N");$i++){
$shift = array_shift($stack);
array_push($stack,$shift);}
print_r($stack);


	
	
/*$tmp='[{"msg":"msg1","dtime":"dtime1"},{"msg":"msg2","dtime":"dtime2"}]';
$arr= json_decode( $tmp, true);
foreach  ($arr as $v){
	echo $v["msg"]." ".$v["dtime"]."<br>";
}*/

//echo date("Z",time());
/*
require_once('db.php');
		//$r7 = mysqli_query($link, "SELECT DISTINCT operators.id FROM opsites LEFT JOIN operators ON opsites.opid=operators.id WHERE opsites.site='nachalosaita.itgroup.kz' AND  operators.lastvisitdtime>'".date("Y-m-d H:i:s",strtotime ("-10 seconds"))."'");
		//$r7 = mysqli_query($link, "SELECT DISTINCT sitesusers.id, sitesusers.* FROM sitesusers LEFT JOIN usersopsmsgs ON usersopsmsgs.userid=sitesusers.id AND usersopsmsgs.status=0 WHERE sitesusers.urlsite IN (select site from opsites where opid=1) AND sitesusers.blocked=0 ORDER BY sitesusers.id DESC");
		//$r8 = mysqli_num_rows($r7);
		//while($r9 = mysqli_fetch_assoc($r7)){
		//	echo print_r($r9,true);
		//}
//echo $r8."  ==";


//$to  = 'emailbsuv@gmail.com' ;
$subject = 'Re: Чат на сайте '.rand(0,255);
$message = '
<html>
<head>
  <title></title>
</head>
<body>
  <p>Сообщение с сайта</p>
  <table>
    <tr>
      <td><hr size="1"></td>
    </tr>
    <tr>
      <td><img src="https://nachalosaita.itgroup.kz/img/l1.png" border="0"></td>
    </tr>
  </table>
</body>
</html>
';
$headers  = 'MIME-Version: 1.0' . "\r\n";
$headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
$headers .= 'To: Суворов Богдан <emailbsuv@gmail.com>' . "\r\n";
$headers .= 'From: Birthday Reminder <noreply@nachalosaita.itgroup.kz>' . "\r\n";
//mail('', $subject, $message, $headers);
$email='Суворов Богдан <emailbsuv@gmail.com>';
sendMail($email,$message,$subject);
    function sendMail($email,$message,$subject)
    {
        $to  = $email;      
        $subject = '=?utf-8?b?'. base64_encode($subject) .'?=';
        $fromMail = 'nachalosaita@nachalosaita.itgroup.kz';
        $fromName = 'Богдан';
        $date = date(DATE_RFC2822);
        $messageId='<'.time().'-'.md5($fromMail.$to).'@'.$_SERVER['SERVER_NAME'].'>';
        $headers  = 'MIME-Version: 1.0' . "\r\n";
        $headers .= "Content-type: text/html; charset=utf-8". "\r\n";
        $headers .= "From: ". $fromName ." <". $fromMail ."> \r\n";
        $headers .= "Date: ". $date ." \r\n";
        $headers .= "Message-ID: ". $messageId ." \r\n";

        return mail($to, $subject, $message, $headers); 
    }
*/

?>

<script language="javascript">
Date.prototype.setTimezoneOffset = function(minutes) {
	var _minutes;
	if (this.timezoneOffset == _minutes) {
		_minutes = this.getTimezoneOffset();
	} else {
		_minutes = this.timezoneOffset;
	}
	if (arguments.length) {
		this.timezoneOffset = minutes;
	} else {
		this.timezoneOffset = minutes = this.getTimezoneOffset();
	}
	return this.setTime(this.getTime() + (_minutes - minutes) * 6e4);
};
var t = new Date('2017-03-11 23:30:00');
t.setTimezoneOffset(t.getTimezoneOffset()*2);
//alert(t.toLocaleString());


</script>