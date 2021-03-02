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
</style>
<script language="javascript">
function ShowHint(id) {
	document.getElementById('div'+id).style.position = "absolute";
    document.getElementById('div'+id).style.display = "block";
	var rect = document.getElementById('img'+id).getBoundingClientRect();
    
	document.getElementById('div'+id).style.left = rect.left;
	document.getElementById('div'+id).offsetTop = rect.top + document.getElementById('img'+id).offsetHeight+10;
}
function HideHint(id) {
    document.getElementById('div'+id).style.display = "none";
}
function ShowHint1(id) {
	document.getElementById('div1_'+id).style.position = "absolute";
    document.getElementById('div1_'+id).style.display = "block";
	var rect = document.getElementById('img1_'+id).getBoundingClientRect();
    
	document.getElementById('div1_'+id).style.left = document.getElementById('img1_'+id).offsetLeft +35;
	document.getElementById('div1_'+id).offsetTop = rect.top + document.getElementById('img1_'+id).offsetHeight+10;
}
function HideHint1(id) {
    document.getElementById('div1_'+id).style.display = "none";
}
function Click1(id) {
	if(document.getElementById('img1_'+id).style.borderWidth  != "3px")
    document.getElementById('img1_'+id).style.border = "solid 3px #12CC58";
    else
	document.getElementById('img1_'+id).style.border = "solid 0px #12CC58";
}
function appointop(site) {
	document.getElementById('site').innerText = site;
    document.getElementById('backdrop').style.display = "block";
	document.getElementById('backdrop').style.top = document.getElementById('header').style.bottom;
	var rect = document.getElementById('footer').getBoundingClientRect();
	var rect1 = document.getElementById('header').getBoundingClientRect();
	document.getElementById('backdrop').style.height = rect.top-rect1.height;
	
	document.getElementById('appointop').style.display = "block";
	
	let elements = document.getElementById( site ).getElementsByTagName('img');
	let elements1 = document.getElementById( 'oplist' ).getElementsByTagName('img');
	for (let elem1 of elements1) {
		elem1.style.border = "solid 0px #12CC58";
	}
	for (let elem of elements) {
		let elements1 = document.getElementById( 'oplist' ).getElementsByTagName('img');
        for (let elem1 of elements1) {
			if(elem.src != '')if(elem.id.substr(7) == elem1.id.substr(5))elem1.style.border = "solid 3px #12CC58";
		}
    }
}
function hidebackdrop() {
    document.getElementById('backdrop').style.display = "none";
	document.getElementById('appointop').style.display = "none";
}
function ApplySiteOps(){
	let elements1 = document.getElementById( 'oplist' ).getElementsByTagName('img');
	var ops = [];
	for (let elem1 of elements1) {
		if(elem1.src != '')if(elem1.style.borderWidth == "3px"){
			ops.push(elem1.id.substr(5));
		}
	}
	$.ajax({
		type: 'POST', url: '{{ asset('applysiteops') }}',  
		data: {'_token':"{{ csrf_token() }}", 'site' : document.getElementById('site').innerText, 'ops[]' : ops }, 
		beforeSend: function(){},
		success: function(data){ 
			document.location.reload(true);
		}
	});
	
}
</script>
<title>Панель управления разработчика</title>
<body>
@include('header_home')
<center><div id="backdrop" class="backdrop" style="display:none" onclick="hidebackdrop();" ></div><div id="appointop" style="z-index:6;display:none;position:absolute;top: 50%;left: 50%;margin-right: -50%;transform: translate(-50%, -50%);background: white;width:380px;height:250px;"><span style="color:#000000;float:right;margin:10px;cursor:pointer;" onclick="hidebackdrop();">x</span><span style="font-size: 28px;color:#CFCFCF;margin-left:35px;margin-top:15px;margin-bottom:5px;float:left;">Назначить оператора</span><span id="site" style="padding-left:35px;float:left;font-family:Arial;color:#434359;font-size:20px;">itgroup.kz</span>
<table width="100%" border="0" style="float:left;padding-left:35px;padding-right:35px;padding-top:15px;padding-bottom:15px;"><tr><td>
<div id="oplist"><img>
@foreach ($oplist["op"] as $op)
<div id="div1_{{ $op[3] }}" style="font-family: Arial; background: #4D6373; padding:5px;color:#FFFFFF;font-size: 11px;display:none">{{ $op[0] }}<br><span style="font-family: Arial; background: #4D6373; color:#37B965;font-size: 11px;">{{ $op[2] }}</span></div><img id="img1_{{ $op[3] }}" src="/img/{{ $op[1] }}" onmousemove="ShowHint1({{ $op[3] }})" onmouseout="HideHint1({{ $op[3] }})" onclick="Click1({{ $op[3] }})" style="cursor: pointer;border:solid 0px #12CC58;border-radius: 5px;">
@endforeach
</div>
</td></tr>
<tr><td><br>
<span style="background:#34BB65;padding-left:10px;padding-right:10px;padding-top:5px;padding-bottom:5px;color:#FFFFFF;font-family:Arial;font-size:14px;" onclick="ApplySiteOps();">ПОДТВЕРДИТЬ</span>
</td></tr></table>

</div>
<table width="70%" border="0" class="menu">
<tr><td align="left" valign="middle" colspan="3" style="padding-top:15px;padding-bottom:10px;"><font color="#D4D4D4" size="5">Сайты</font></td></tr>
<tr><td align="left" valign="middle" colspan="3"><hr size="1" color="#D4D4D4"></td></tr>
@foreach ($sites as $site)
  <tr><td align="left" valign="middle" style="font-family: Arial; color: #9F9F9F;font-size: 10px;" width="280"><span style="font-family: Arial; color: #393D51;font-size: 18px;">{{ $site->site }}</span><br><span style="font-family: Arial; color: #393D51;font-size: 13px;">{{ $site->notaccepted }}</span> ПРОПУЩЕНО<br><span style="font-family: Arial; color: #393D51;font-size: 13px;">{{ $site->accepted }}</span> ПРИНЯТО <br><br><span style="border:1px solid #DDDDDD; padding:3px;margin:3px;color:#535566;">Статистика</span><a href="{{ asset('callhistoryoperatorsite') }}/{{ $site->site }}" style="font-family:Arial;color:#949494;font-size:10px;text-decoration:none;"><span style="border:1px solid #DDDDDD; padding:3px;margin:3px;color:#535566;">Журнал</span></a><a href="{{ asset('settingssites') }}/{{ $site->site }}" style="font-family:Arial;color:#949494;font-size:10px;text-decoration:none;"><span style="border:1px solid #DDDDDD; padding:3px;margin:3px;color:#535566;">Настройки</span></a></td><td id="{{ $site->site }}"><img>{!! $site->ops !!}</td><td style="font-family: Arial; color: #9F9F9F;font-size: 12px;cursor:pointer;" align="center" width="130" onclick="appointop('{{ $site->site }}');"><img src="/img/appointop.png" border="0"><br>НАЗНАЧИТЬ<br>ОПЕРАТОРА</td></tr>
  <tr><td align="left" valign="middle" colspan="3"><hr size="1" color="#D4D4D4"></td></tr>
@endforeach
</table>
</center>
@include('footer')
</body>
</html>