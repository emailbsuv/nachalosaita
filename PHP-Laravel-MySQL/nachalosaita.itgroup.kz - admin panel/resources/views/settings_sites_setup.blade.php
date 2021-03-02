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
<tr><td align="left" valign="middle" style="padding-top:15px;padding-bottom:10px;"><font color="#D4D4D4" size="5">Настройка сайта</font>
</td></tr>
<tr><td align="left" valign="middle">

<table width="100%" border="0" style="margin:0px;padding-left:20px;" cellpadding="0" cellspacing="0">
<tr><td align="left" valign="top" width="65%" style="border-right:1px solid #D1D1D1;">

<table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family:Arial;color:#3C5567;font-size:13px;">
<tr>
<td align="left" valign="top" style="padding-top:10px;padding-bottom:10px;padding-left:15px;"> {{ $sitesproperties[0]->site }}</td>
</tr>
</table>

</td>
</tr>
</table>

</td></tr>
<tr><td align="left" valign="middle" style="padding-top:25px;padding-bottom:25px;">
</td></tr>

</table>
</center>
@include('footer')
</body>
</html>