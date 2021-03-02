<html>
<meta charset="utf-8">
<link rel="stylesheet" href="{{ asset('css/stylesheet.css') }}" />
<script type="text/javascript" src="{{ URL::asset('js/jquery-3.5.1.min.js') }}"></script>
<style>
html,body
{
	padding: 0;
	margin: 0;
	width: 100%;
	height: 100%;
	font-family: Arial;
	font-size: 12px;
}
td.td1:hover { background-color: #5B7585; }
td.td2:hover { background-color: #E3E3E3; }
.backdrop {
  position: absolute;
  width: 100%;
  left: 0;
  background: rgba(0,0,0,.5);
  opacity: 1;
  transition: opacity 0.3s ease;
  z-index: 5;
}
.menu:hover + .backdrop {
  left: 0;
  opacity: 1;
}
.cell1{border-right:1px solid #D1D1D1;border-bottom:1px solid #D1D1D1;}
.cell2{border-right:1px solid #D1D1D1;border-bottom:1px solid #D1D1D1;font-family:Arial;color:#A7A7A7;font-size:13px;}
</style>
<script language="javascript">
function appointop(site) {
	document.getElementById('site').innerText = site;
	document.getElementById('sitelist').style.display = "none";
    document.getElementById('backdrop').style.display = "block";
	document.getElementById('backdrop').style.top = document.getElementById('header').style.bottom;
	var rect = document.getElementById('footer').getBoundingClientRect();
	var rect1 = document.getElementById('header').getBoundingClientRect();
	document.getElementById('backdrop').style.height = rect.top-rect1.height;
	
	document.getElementById('appointop').style.display = "block";
}
function setsite(site) {
	document.getElementById('site').innerText = site;
	document.getElementById('sitelist').style.display = "none";
}
function hidebackdrop() {
    document.getElementById('backdrop').style.display = "none";
	document.getElementById('appointop').style.display = "none";
}
function ShowHideSites() {
	if(document.getElementById('sitelist').style.display == "block") document.getElementById('sitelist').style.display = "none";
    else document.getElementById('sitelist').style.display = "block";
	var rect = document.getElementById('site').getBoundingClientRect();
    
	document.getElementById('sitelist').style.left = document.getElementById('site').offsetLeft +35 + 'px';
	document.getElementById('sitelist').style.top = document.getElementById('site').offsetTop + document.getElementById('site').offsetHeight + 'px';
}
function ApplySites(){
	var allok=true;
	if(document.getElementById("name").value==''){document.getElementById("name").style.border = "1px solid red";allok=false;}
	else document.getElementById("name").style.border = "1px solid #D2D4D8";
	if(document.getElementById("email").value==''){document.getElementById("email").style.border = "1px solid red";allok=false;}
	else document.getElementById("email").style.border = "1px solid #D2D4D8";
	if(document.getElementById("password").value==''){document.getElementById("password").style.border = "1px solid red";allok=false;}
	else document.getElementById("password").style.border = "1px solid #D2D4D8";
	
	if(allok){
		$.ajax({
		type: 'POST', url: '{{ asset('addoperator') }}',  
		data: {'_token':"{{ csrf_token() }}", 'site' : document.getElementById('site').innerText, 'name' : document.getElementById("name").value , 'email' : document.getElementById("email").value , 'password' : document.getElementById("password").value, 'admin' : document.getElementById("admin").checked }, 
		beforeSend: function(){},
		success: function(data){ 
			document.location.reload(true);
		}
		});
	}
}
</script>
<title>Панель управления разработчика</title>
<body>
@include('header_home')

<center>

<div id="backdrop" class="backdrop" style="display:none" onclick="hidebackdrop();" ></div><div id="appointop" style="z-index:6;display:none;position:absolute;top: 50%;left: 50%;margin-right: -50%;transform: translate(-50%, -50%);background: white;width:380px;height:260px;"><span style="color:#000000;float:right;margin:10px;cursor:pointer;" onclick="hidebackdrop();">x</span><span style="font-size: 28px;color:#CFCFCF;margin-left:35px;margin-top:15px;margin-bottom:5px;float:left;">Добавить оператора</span><span id="site" style="padding-left:35px;float:left;font-family:Arial;color:#434359;font-size:20px;" onclick="ShowHideSites();">itgroup.kz</span>

<div id="sitelist" style="display:none;position:absolute;background: white;">
<table width="100%" style="border: 1px solid #D9D9D9;" cellpadding="0" cellspacing="0">
@foreach ($sites as $site)
<tr><td class="td2" style="font-family:Arial;color:#515567;font-size:15px;padding:5px;" onclick="setsite('{{ $site->site }}')">{{ $site->site }}</td></tr>
@endforeach
</table>
</div>
<table width="100%" border="0" style="float:left;padding-left:35px;padding-right:35px;padding-top:15px;padding-bottom:15px;">
<tr><td style="font-family:Arial;color:#515567;font-size:13px;">Имя</td><td><input type="text" id="name" style="border: 1px solid #D9D9D9;"></td></tr>
<tr><td style="font-family:Arial;color:#515567;font-size:13px;">Email</td><td><input type="text" id="email" style="border: 1px solid #D9D9D9;"></td></tr>
<tr><td style="font-family:Arial;color:#515567;font-size:13px;">Пароль</td><td><input type="text" id="password" style="border: 1px solid #D9D9D9;"></td></tr>
<tr><td colspan="2" style="font-family:Arial;color:#515567;font-size:13px;">Права администратора <input type="checkbox" id="admin" checked></td></tr>
<tr><td colspan="2"><br>
<span style="background:#34BB65;padding-left:10px;padding-right:10px;padding-top:5px;padding-bottom:5px;color:#FFFFFF;font-family:Arial;font-size:14px;" onclick="ApplySites();">ПОДТВЕРДИТЬ</span>&nbsp;&nbsp;&nbsp;<span style="background:#34BB65;padding-left:10px;padding-right:10px;padding-top:5px;padding-bottom:5px;color:#FFFFFF;font-family:Arial;font-size:14px;" onclick="hidebackdrop();">ОТМЕНИТЬ</span>
</td></tr></table>
</div>


<table width="70%" border="0" >
<tr><td align="left" valign="middle" style="padding-top:15px;padding-bottom:10px;"><font color="#D4D4D4" size="5">Операторы</font>
<span style="float:right;margin:10px;cursor:pointer;font-family:Arial;color:#9F9F9F;font-size:13px;" onclick="appointop('itgroup.kz');"><img src="/img/appointop.png" border="0"> ДОБАВИТЬ ОПЕРАТОРА</span>
</td></tr>
<tr><td align="left" valign="middle">

<table width="100%" border="0" style="margin:0px;padding:10px;font-family:Arial;color:#4591BB;font-size:13px;" cellpadding="0" cellspacing="0">
<tr height="22"><td rowspan="2" align="center" valign="middle" class="cell1">Оператор</td><td rowspan="2" align="center" valign="middle"style="border-bottom:1px solid #D1D1D1">Принято</td><td rowspan="2" align="center" valign="middle" style="background:#F0F0F0;border-bottom:1px solid #D1D1D1;">Пропущено</td><td rowspan="2" align="center" valign="middle" class="cell1">Время ответа</td><td colspan="7" align="center" valign="middle">Время в онлайне
</td></tr>
<tr height="22"><td align="center" valign="middle" class="cell1" style="background:#F0F0F0;" width="50">{{ $daylist[0] }}</td><td align="center" valign="middle" class="cell1" width="50">{{ $daylist[1] }}</td><td align="center" valign="middle" class="cell1" style="background:#F0F0F0;" width="50">{{ $daylist[2] }}</td><td align="center" valign="middle" class="cell1" width="50">{{ $daylist[3] }}</td><td align="center" valign="middle" class="cell1" style="background:#F0F0F0;" width="50">{{ $daylist[4] }}</td><td align="center" valign="middle" class="cell1" width="50">{{ $daylist[5] }}</td><td align="center" valign="middle" class="cell1" style="background:#F0F0F0;" width="50">{{ $daylist[6] }}</td>
</td></tr>
@foreach ($oplist["op"] as $op)
<tr height="85">
<td align="left" valign="middle" class="cell2" style="padding-left:20px;">
<table cellpadding="0" cellspacing="0" border="0"><tr><td><img src="/img/{{ $op[1] }}" border="0"></td><td style="padding-left:5px;font-family:Arial;color:#505165;font-size:14px;">{{ $op[0] }}<br>{!! $op[2] !!}</td></tr><tr><td colspan="2" style="padding-top:10px;"><a href="{{ asset('settingsoperator') }}/{{ $op[3] }}" style="font-family:Arial;color:#949494;font-size:13px;text-decoration:underline;">Настройки</a>  <a href="{{ asset('callhistoryoperator') }}/{{ $op[3] }}" style="font-family:Arial;color:#949494;font-size:13px;text-decoration:underline;">Журнал</a></td></tr></table>

</td><td align="center" valign="middle" style="border-bottom:1px solid #D1D1D1;color:#A7A7A7;">{{ $op[4] }}</td><td align="center" valign="middle" style="background:#F0F0F0;border-bottom:1px solid #D1D1D1;color:#A7A7A7;">{{ $op[5] }}</td><td align="center" valign="middle" class="cell2">{{ $op[6] }}</td>

<td align="center" valign="bottom" class="cell1" style="background:#F0F0F0;"><span title="{{ $op[7][1] }}" style="width:100%;height:{{ $op[7][0] }}%;background:#4BD57F;display:inline-block"></span></td><td align="center" valign="bottom" class="cell1"><span title="{{ $op[8][1] }}" style="width:100%;height:{{ $op[8][0] }}%;background:#4BD57F;display:inline-block"></span></td><td align="center" valign="bottom" class="cell1" style="background:#F0F0F0;"><span title="{{ $op[9][1] }}" style="width:100%;height:{{ $op[9][0] }}%;background:#4BD57F;display:inline-block"></span></td><td align="center" valign="bottom" class="cell1"><span title="{{ $op[10][1] }}" style="width:100%;height:{{ $op[10][0] }}%;background:#4BD57F;display:inline-block"></span></td><td align="center" valign="bottom" class="cell1" style="background:#F0F0F0;"><span title="{{ $op[11][1] }}" style="width:100%;height:{{ $op[11][0] }}%;background:#4BD57F;display:inline-block"></span></td><td align="center" valign="bottom" class="cell1"><span title="{{ $op[12][1] }}" style="width:100%;height:{{ $op[12][0] }}%;background:#4BD57F;display:inline-block"></span></td><td align="center" valign="bottom" class="cell1" style="background:#F0F0F0;"><span title="{{ $op[13][1] }}" style="width:100%;height:{{ $op[13][0] }}%;background:#4BD57F;display:inline-block"></span></td>
</td></tr>
@endforeach
</table>

</td></tr>


</table>
</center>
@include('footer')
</body>
</html>