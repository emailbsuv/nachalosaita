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
<tr><td align="left" valign="middle"><table border="0" cellpadding="0" cellspacing="0"><tr><td align="center" valign="middle"><img border="0" src="/img/{{ $op[0]->jpgname }}"></td><td align="center" valign="middle" style="font-family:Arial;color:#3C5567;font-size:20px;padding-left:20px;">{{ $op[0]->name }}</td></tr></table></td></tr>
<tr><td align="left" valign="middle">

<table width="100%" border="0" style="margin:0px;padding-left:20px;" cellpadding="0" cellspacing="0">
<tr><td align="left" valign="top" width="65%" style="border-right:1px solid #D1D1D1;">

<table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family:Arial;color:#3C5567;font-size:13px;">
@foreach ($msgs as $msg)
<tr style="background:#{{ $msg->bgcolor }};">
<td align="center" valign="middle" width="100" style="padding-top:10px;padding-bottom:10px;">{{ $msg->dtime }}</td>
<td align="center" valign="middle" width="60" style="padding-top:10px;padding-bottom:10px;">{{ $msg->time }}</td>
<td align="left" valign="top" style="padding-top:10px;padding-bottom:10px;padding-left:15px;">{!! $msg->msg !!}</td>
</tr>
@endforeach
</table>

</td><td align="left" valign="top" width="35%" style="padding-left:20px;font-family:Arial;color:#3C5567;font-size:13px;">{{ $user[0]->name }}<br><br>{{ $user[0]->phone }}<br><br>{{ $user[0]->email }}<br><br>Ожидал ответа <span style="color:#979797;">{{ $waittime }}</span><br><br><span style="color:#979797;">{{ $user[0]->comment }}</span><br><br>{{ $user[0]->ip }}<br><br>{{ $user[0]->refferer }}<br><br>{{ $user[0]->urlsite }}</td>
</tr>
</table>

</td></tr>
<tr><td align="left" valign="middle" style="padding-top:25px;padding-bottom:25px;">
<a href="{{ asset('callhistorydelete') }}/{{ $msg->opid }}/{{ $msg->userid }}" style="text-decoration:none;"><span style="border:1px solid #EB6C6C; padding-top:3px;padding-bottom:3px;padding-left:10px;padding-right:10px;margin:3px;color:#FFFFFF;background:#EB6C6C;font-family:Arial;font-size:14px;">УДАЛИТЬ ДИАЛОГ</span></a>&nbsp;&nbsp;&nbsp;<a href="{{ $referer }}" style="text-decoration:none;"><span style="border:1px solid #D9D9D9; padding-top:3px;padding-bottom:3px;padding-left:10px;padding-right:10px;margin:3px;color:#515567;background:#FFFFFF;font-family:Arial;font-size:14px;">НАЗАД</span></a>
</td></tr>

</table>
</center>
@include('footer')
</body>
</html>