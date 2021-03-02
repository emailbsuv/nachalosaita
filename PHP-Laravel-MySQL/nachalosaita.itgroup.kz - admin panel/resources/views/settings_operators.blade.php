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
function showbackdrop() {
    document.getElementById('backdrop').style.display = "block";
	document.getElementById('backdrop').style.top = document.getElementById('header').style.bottom;
	var rect = document.getElementById('footer').getBoundingClientRect();
	var rect1 = document.getElementById('header').getBoundingClientRect();
	document.getElementById('backdrop').style.height = rect.top-rect1.height;
	document.getElementById('appointop').style.display = "block";
}
function hidebackdrop() {
    document.getElementById('backdrop').style.display = "none";
	document.getElementById('appointop').style.display = "none";
}
function delsite(site) {
	let elements = document.getElementById('sites').getElementsByTagName('tr');
	for (let elem of elements) {
		if(elem.id == site) elem.parentNode.removeChild(elem);
	}
}
function AddSite() {
if(document.getElementById('site').value.length <4)document.getElementById("site").style.border = "1px solid red";
	else {
		document.getElementById("site").style.border = "1px solid #D2D4D8";
		var tr = document.createElement("TR");
		var td = document.createElement("TD");
		var td2 = document.createElement("TD");
		td.innerHTML='<span style="font-family:Arial;color:#505568;font-size:14px;">'+document.getElementById('site').value+'</span>';
		td.style = "padding-top:10px;padding-bottom:10px;";
		td2.innerHTML='<span style="font-family:Arial;font-size:13px;color:#535566;" onclick="delsite(\''+document.getElementById('site').value+'\')"><img src="/img/off.png" border="0"> ОТКЛЮЧИТЬ ОПЕРАТОРА ОТ САЙТА</span>';
		tr.appendChild(td);
		tr.appendChild(td2);
		tr.id = document.getElementById('site').value;
		if((Math.floor(document.getElementById("sites").getElementsByTagName("tr").length / 2) * 2 ) == document.getElementById("sites").getElementsByTagName("tr").length) tr.style = "background:#FFFFFF"; else tr.style = "background:#F2F2F2";
		document.getElementById("sites").appendChild(tr);
		document.getElementById('site').value = '';
		hidebackdrop();
	}
}
function SetImg(input){
 var ext = input.files[0]["name"].substring(input.files[0]["name"].lastIndexOf(".") + 1).toLowerCase();
if (input.files && input.files[0] && (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg")) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $("#foto").attr("src", e.target.result);
    }

    reader.readAsDataURL(input.files[0]);
}else{
     $("#foto").attr("src", "/img/foto.jpg");
}
}
function save(){
	var file_data = $('#fotofile').prop('files')[0];   
    var form_data = new FormData();                  
    form_data.append('file', file_data);
	form_data.append('name', document.getElementById('name').value);
	form_data.append('position', document.getElementById('position').value);
	form_data.append('email', document.getElementById('email').value);
	form_data.append('password', document.getElementById('password').value);
	form_data.append('admin', document.getElementById('admin').checked);
	form_data.append('_token', "{{ csrf_token() }}");
	let elements = document.getElementById('sites').getElementsByTagName('tr');
	for (let elem of elements) {
		form_data.append('sites[]', elem.id);
	}
    //alert(form_data);                             
    $.ajax({
        url: '{{ asset('settingsoperator') }}/{{ $operator[0]->id }}', 
        dataType: 'text',  
        cache: false,
        contentType: false,
        processData: false,
		data:form_data,
        type: 'post',
        success: function(data){alert('Сохранено');}
     });
}
function deloperator(){
		$.ajax({
		type: 'POST', url: '{{ asset('deloperator') }}/{{ $operator[0]->id }}',  
		data: {'_token':"{{ csrf_token() }}" }, 
		beforeSend: function(){},
		success: function(data){ 
			document.location = '{{ asset('home_operators') }}';
		}
		});	
}
</script>
<title>Панель управления разработчика</title>
<body>
@include('header_home')

<center>

<div id="backdrop" class="backdrop" style="display:none" onclick="hidebackdrop();" ></div><div id="appointop" style="z-index:6;display:none;position:absolute;top: 50%;left: 50%;margin-right: -50%;transform: translate(-50%, -50%);background: white;width:340px;height:175px;"><span style="color:#000000;float:right;margin:10px;cursor:pointer;" onclick="hidebackdrop();">x</span><span style="font-size: 28px;color:#CFCFCF;margin-left:35px;margin-top:15px;margin-bottom:5px;float:left;">Назначить на сайт</span>

<table width="100%" border="0" style="float:left;padding-left:35px;padding-right:35px;padding-top:15px;padding-bottom:15px;">
<tr><td style="font-family:Arial;color:#515567;font-size:13px;">Сайт</td><td><input type="text" id="site" style="border: 1px solid #D9D9D9;"></td></tr>
<tr><td colspan="2"><br>
<span style="background:#34BB65;padding-left:10px;padding-right:10px;padding-top:5px;padding-bottom:5px;color:#FFFFFF;font-family:Arial;font-size:14px;" onclick="AddSite();">ПОДТВЕРДИТЬ</span>&nbsp;&nbsp;&nbsp;<span style="background:#34BB65;padding-left:10px;padding-right:10px;padding-top:5px;padding-bottom:5px;color:#FFFFFF;font-family:Arial;font-size:14px;" onclick="hidebackdrop();">ОТМЕНИТЬ</span>
</td></tr></table>
</div>


<table width="70%" border="0" >
<tr><td align="left" valign="middle" style="padding-top:15px;padding-bottom:10px;"><font color="#D4D4D4" size="5">Настройка оператора</font>
</td></tr>
<tr><td align="left" valign="middle">

<table width="100%" border="0" style="margin:0px;padding:10px;font-family:Arial;color:#4591BB;font-size:13px;" cellpadding="0" cellspacing="0">
<tr><td align="left" valign="middle" width="50">
<img src="/img/{{ $operator[0]->jpgname}}" border="0" id="foto" width="32" height="32"></td><td>
<input type="file" name="fotofile" id="fotofile" accept="image/jpeg,image/png,image/gif" onChange="SetImg(this);" style="display: none;">
<span style="margin:0px;font-family:Arial;border:1px solid #DDDDDD; padding:3px;margin:3px;color:#535566;font-size:13px;" onclick="$('#fotofile').trigger('click');">Изменить фото</span>
</td></tr>
</table>

</td></tr>
<tr><td>

<table width="100%" border="0" style="margin:0px;padding:10px;font-family:Arial;color:#4591BB;font-size:13px;" cellpadding="0" cellspacing="0">
<tr><td align="left" valign="middle" width="340" style="padding-top:15px;padding-bottom:15px;"><span style="font-family:Arial;color:#505568;font-size:14px;">Имя</span><br><span style="font-family:Arial;color:#9B9B9B;font-size:12px;">Имя оператора которое будет отображаться посетителям</span></td><td><input type="text" id="name" style="border: 1px solid #D9D9D9;" value="{{ $operator[0]->name}}"></td></tr>
<tr><td align="left" valign="middle" width="340" style="padding-top:15px;padding-bottom:15px;"><span style="font-family:Arial;color:#505568;font-size:14px;">Должность</span><br><span style="font-family:Arial;color:#9B9B9B;font-size:12px;">Должность которая будет отображаться в чате</span></td><td><input type="text" id="position" style="border: 1px solid #D9D9D9;" value="{{ $operator[0]->position}}"></td></tr>
<tr><td align="left" valign="middle" width="340" style="padding-top:15px;padding-bottom:15px;"><span style="font-family:Arial;color:#505568;font-size:14px;">Email</span><br><span style="font-family:Arial;color:#9B9B9B;font-size:12px;">Email которое используется для отправки различных уведомлений, а также является логином при входе в личный кабинет и приложение НачалоСайта</span></td><td><input type="text" id="email" style="border: 1px solid #D9D9D9;" value="{{ $operator[0]->login}}"></td></tr>
<tr><td align="left" valign="middle" width="340" style="padding-top:15px;padding-bottom:15px;"><span style="font-family:Arial;color:#505568;font-size:14px;">Пароль</span><br><span style="font-family:Arial;color:#9B9B9B;font-size:12px;">Минимальная длина пароля - 6 символов. Обязательно наличие больших букв и цифр</span></td><td><input type="text" id="password" style="border: 1px solid #D9D9D9;" value="{{ $operator[0]->password}}"></td></tr>
<tr><td align="left" valign="middle" width="340" style="padding-top:15px;padding-bottom:15px;"><span style="font-family:Arial;color:#505568;font-size:14px;">Права администратора</span><br><span style="font-family:Arial;color:#9B9B9B;font-size:12px;">Администратор может входить в личный кабинет, управлять сайтами, настройками и аккаунтами операторов и может просматривать журналы диалогов</span></td><td><input type="checkbox" id="admin" style="border: 1px solid #D9D9D9;" checked></td></tr>
</table>

</td></tr>
<tr><td>

<table width="100%" border="0" style="margin:0px;padding:20px;font-family:Arial;color:#4591BB;font-size:13px;" cellpadding="0" cellspacing="0" id="sites">
<tr><td align="left" valign="middle" width="340" style="padding-top:15px;padding-bottom:15px;"><span style="font-family:Arial;color:#505568;font-size:14px;">Сайты, на которые назначен оператор</span></td><td><span style="border:1px solid #DDDDDD; padding-top:3px;padding-bottom:3px;padding-left:10px;padding-right:10px;margin:3px;color:#535566;" onclick="showbackdrop();">Назначить на сайт</span></td></tr>
@foreach ($opsites as $site)
<tr style="background:#{{ $site->bgcolor }}" id="{{ $site->site }}"><td style="padding-top:10px;padding-bottom:10px;" align="left" valign="middle" width="340"><span style="font-family:Arial;color:#505568;font-size:14px;">{{ $site->site }}</span></td><td><span style="font-family:Arial;font-size:13px;color:#535566;" onclick="delsite('{{ $site->site }}')"><img src="/img/off.png" border="0"> ОТКЛЮЧИТЬ ОПЕРАТОРА ОТ САЙТА</span></td></tr>
@endforeach
</table>

<table width="100%" border="0" style="margin:0px;padding:0px;font-family:Arial;color:#4591BB;font-size:13px;" cellpadding="0" cellspacing="0">
<tr><td style="padding-top:30px;padding-bottom:30px;" align="left" valign="middle" width="340"><span style="border:1px solid #DDDDDD; padding-top:3px;padding-bottom:3px;padding-left:10px;padding-right:10px;margin:3px;color:#FFFFFF;background:#34BA65;" onclick="save();">СОХРАНИТЬ</span>&nbsp;&nbsp;&nbsp;<span style="border:1px solid #DDDDDD; padding-top:3px;padding-bottom:3px;padding-left:10px;padding-right:10px;margin:3px;color:#515567;background:#FFFFFF;" onclick="document.location.reload(true);">ОТМЕНА</span></td><td><span style="float:right;border:1px solid #DDDDDD; padding-top:3px;padding-bottom:3px;padding-left:10px;padding-right:10px;margin:3px;color:#FFFFFF;background:#EB6C6C;" onclick="deloperator();">УДАЛИТЬ ОПЕРАТОРА</span></td></tr>
</table>

</td></tr>
</table>
</center>
@include('footer')
</body>
</html>