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
</script>
<title>Панель управления разработчика</title>
<body>
@include('header_home')

<center>

<table width="70%" border="0" >
<tr><td align="left" valign="middle" style="padding-top:15px;padding-bottom:10px;"><font color="#D4D4D4" size="5">История обращений</font>
</td></tr>
<tr><td align="left" valign="middle">

<table width="100%" border="0" style="margin:0px;padding:10px;font-family:Arial;color:#4591BB;font-size:13px;" cellpadding="0" cellspacing="0">
<tr height="50"><td align="center" valign="middle" class="cell1" width="200">Начало обращения</td><td align="center" valign="middle" style="border-bottom:1px solid #D1D1D1;background:#F0F0F0;">Оператор</td><td align="center" valign="middle" style="border-bottom:1px solid #D1D1D1;">Клиент</td><td align="center" valign="middle" style="border-bottom:1px solid #D1D1D1;background:#F0F0F0;">Время</td><td align="center" valign="middle" style="border-bottom:1px solid #D1D1D1;">Сообщений</td><td width="130" class="cell1" style="background:#F0F0F0;" align="center" valign="middle"> </td><td width="120" style="border-bottom:1px solid #D1D1D1;" align="center" valign="middle"> </td></tr>
@foreach ($msgs as $msg)
<tr height="65">
<td align="center" valign="middle" class="cell1" style="color:#050505;">{{ $msg->dtime }}</td>
<td align="center" valign="middle" style="border-bottom:1px solid #D1D1D1;background:#F0F0F0;"><table width="100%" border="0" style="margin:0px;padding:10px;font-family:Arial;color:#050505;font-size:13px;" cellpadding="0" cellspacing="0"><tr><td width="34"><img border="0" src="/img/{{ $msg->jpgname }}"></td><td style="padding-left:10px;">{{ $msg->name }}<br>{!! $msg->status !!}</td></tr></table></td>
<td align="left" valign="middle" style="border-bottom:1px solid #D1D1D1;color:#050505;padding-left:35px;">{{ $msg->uname }}</td>
<td align="center" valign="middle" style="border-bottom:1px solid #D1D1D1;background:#F0F0F0;color:#AEAEAE;">{{ $msg->time }}</td>
<td align="center" valign="middle" style="border-bottom:1px solid #D1D1D1;color:#AEAEAE;">{{ $msg->msgcnt }}</td>
<td align="center" valign="middle" class="cell1" style="background:#F0F0F0;color:#4E5265;"><a href="{{ asset('callhistoryview') }}/{{ $msg->opid }}/{{ $msg->userid }}" style="font-family:Arial;color:#4E5265;font-size:13px;text-decoration:none;"><img src="/img/view.png" border="0"> ПРОСМОТР</a></td>
<td align="center" valign="middle" style="border-bottom:1px solid #D1D1D1;color:#B3B3B3;"><a href="{{ asset('callhistorydelete') }}/{{ $msg->opid }}/{{ $msg->userid }}" style="font-family:Arial;color:#4E5265;font-size:13px;text-decoration:none;"><img src="/img/del.png" border="0"> УДАЛИТЬ</a></td>
</tr>
@endforeach
</table>

</td></tr>


</table>
</center>
@include('footer')
</body>
</html>