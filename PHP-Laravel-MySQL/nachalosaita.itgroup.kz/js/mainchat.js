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
function setCookie(cname, cvalue, exdays) {
  var d = new Date();
  d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
  var expires = "expires="+d.toUTCString();
  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
  var name = cname + "=";
  var ca = document.cookie.split(';');
  for(var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}

var chatX=0;var chatY=0;var chatOn=true;
function dragElement(elmnt) {
//	  document.getElementById("mydiv").onclick = null;
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  if (document.getElementById(elmnt.id + "header")) {
    // if present, the header is where you move the DIV from:
    document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
  } else {
    // otherwise, move the DIV from anywhere inside the DIV:
    elmnt.onmousedown = dragMouseDown;
  }

  function dragMouseDown(e) {
    e = e || window.event;
    e.preventDefault();
    // get the mouse cursor position at startup:
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();
    // calculate the new cursor position:
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
    // set the element's new position:
    if(((elmnt.parentNode.offsetTop - pos2)>0) & ((elmnt.parentNode.offsetTop - pos2)<=(window.innerHeight-540)))chatY = elmnt.parentNode.style.top = (elmnt.parentNode.offsetTop - pos2) + "px";
    if(((elmnt.parentNode.offsetLeft - pos1)>10) & ((elmnt.parentNode.offsetLeft - pos1)<=(window.innerWidth-343)))chatX = elmnt.parentNode.style.left = (elmnt.parentNode.offsetLeft - pos1) + "px";
	elmnt.style.cursor = "default"; 
	if(document.getElementById('NeedUserData').style.display == 'block')
	document.getElementById('chatform').style.height = (window.innerHeight -elmnt.parentNode.offsetTop -255-190)+'px';
	else
	document.getElementById('chatform').style.height = (window.innerHeight -elmnt.parentNode.offsetTop -255)+'px';

	if(document.getElementById('OfflineMsgSended').style.display == 'block')
	document.getElementById('OfflineMsgSended').style.height = (window.innerHeight -elmnt.parentNode.offsetTop -120)+'px';

	if(document.getElementById('OfflineUserData').style.display == 'block')
	document.getElementById('OfflineUserData').style.height = (window.innerHeight -elmnt.parentNode.offsetTop -42-190)+'px';
	

	elmnt.parentNode.style.height  = (window.innerHeight -elmnt.parentNode.offsetTop -0)+'px';
  }

  function closeDragElement() {
    // stop moving when mouse button is released:
    document.onmouseup = null;
    document.onmousemove = null;
	//document.onclick = null;
	elmnt.style.cursor = "move"; 
  }
}

function closeChat() {
//  document.getElementById("mydiv2").innerText= "";
//  document.getElementById("mydiv").onmousemove = null;
//  document.getElementById('mydiv').removeEventListener('mousemove', dragElement);
//  document.getElementById("mydiv").style.cursor= "pointer";

//  document.getElementById("mydiv3").onmousemove = null;
//  document.getElementById('mydiv3').removeEventListener('mousemove', dragElement);
//  document.getElementById("mydiv3").style.cursor= "pointer";
  
//  document.getElementById("mydiv").onclick = openChat;
//  document.getElementById("mydiv3").onclick = openChat;
  var elem = document.getElementById("mydiv1");
  var qStyle = getComputedStyle(elem);
  var posX = parseInt(qStyle.left|| 0, 10); chatX=posX;
  var posY = parseInt(qStyle.top|| 0, 10); chatY=posY; chatOn=false;
  var id = setInterval(frame, 1);
  function frame() {
    if ((posY >= (window.innerHeight-50)) && (posX >= (window.innerWidth-350))) {
	  clearInterval(id);
	  document.getElementById('buttonchat').style.display='block';
	  document.getElementById('mydiv1').style.display='none';
    } else {
      posX+=(window.innerWidth-350-posX)/25+1;posY+=(window.innerHeight-50-posY)/25+1;
      if (posY < (window.innerHeight-50)) elem.style.top = posY + 'px';
      if (posX < (window.innerWidth-350))elem.style.left = posX + 'px';
    }
  }
}
function openChat() {
//	  document.getElementById("mydiv2").innerText= "X";
//	  document.getElementById("mydiv").onmousemove = "dragElement(document.getElementById('mydiv'))";
//	  document.getElementById("mydiv3").onmousemove = "dragElement(document.getElementById('mydiv3'))";
//	  document.getElementById("mydiv").onclick = null;
	  document.getElementById("mydiv").style.cursor= "move";
	  document.getElementById('buttonchat').style.display='none';
	  document.getElementById('mydiv1').style.display='block';
  var elem = document.getElementById("mydiv1");
  var qStyle = getComputedStyle(elem);
  var chatXint = parseInt(chatX|| 0, 10); 
  var chatYint = parseInt(chatY|| 0, 10); 
  var posX = parseInt(qStyle.left|| 0, 10); 
  var posY = parseInt(qStyle.top|| 0, 10); chatOn=true;
  var id = setInterval(frame, 1);
  function frame() {
    if ((posY <= chatYint) && (posX <= chatXint)) {
	  clearInterval(id);

		document.getElementById('mydiv1').style.height = window.innerHeight+'px';
		if(document.getElementById('NeedUserData').style.display == 'block')
		document.getElementById('chatform').style.height = (window.innerHeight -document.getElementById('mydiv3').parentNode.offsetTop -255-190)+'px';
		else
		document.getElementById('chatform').style.height = (window.innerHeight -document.getElementById('mydiv3').parentNode.offsetTop -255)+'px';
		elmnt.parentNode.style.height  = (window.innerHeight -document.getElementById('mydiv3').parentNode.offsetTop -0)+'px';
		
		//document.getElementById('mainform').style.transform = "translateY("+(document.getElementById('mainform').offsetHeight *-1 +document.getElementById('chatform').offsetHeight)+"px)";
	
	  } else {
      posX-=(posX-chatXint)/25+1;posY-=(posY-chatYint)/25+1;
      if (posY > chatYint) elem.style.top = posY + 'px';
      if (posX > chatXint)elem.style.left = posX + 'px';
    }
  }
  document.getElementById('mainform').style.transform = "translateY("+(document.getElementById('mainform').offsetHeight *-1 +document.getElementById('chatform').offsetHeight)+"px)";
}
window.onresize = function(event) {if(chatOn==false)document.getElementById("mydiv1").style.top=window.innerHeight-50;}
var lastopmsgtime='';var LastChatMessage = '';var LastChatStatusMessage = 0; var onlinestatus = false;
function doupdate(){
	
		$(document).ready(function(){
			
			$.ajax({
				type: 'POST', url: 'https://nachalosaita.itgroup.kz/sitesusers/updateuser.php',  
				data: { 'watch' : document.title,'cookies' : getCookie("nachalosaita"), 'lastopmsgtime' : lastopmsgtime }, 
				beforeSend: function(){
					//alert(lastopmsgtime);
					},
				success: function(data){ 
					var result = $.parseJSON(data);
					for(var i in result[0]){
						var newmsg = document.createElement("DIV");
						var newstr = result[0][i].msg;
						//alert('newstr'); 
						//newstr = newstr.replace('&lt;', '<');newstr.replace(/&gt;/g, '>');
						newstr = newstr.replace('&lt;', '<');newstr = newstr.replace('&gt;', '>');
						//newmsg.innerHTML = newstr;
						var t = new Date(result[0][i].dtime);
						t.setTimezoneOffset(t.getTimezoneOffset()*2);
						newmsg.title =t.toLocaleString();
						var color="A0A0A0";if(result[0][i].toop == 1) color="F0F0F0";
						newmsg.innerHTML = '<font size="2" color="#'+color+'" face="Arial">'+t.toLocaleString()+'</font><br>'+newstr;
						
						newmsg.className ="style8";
						document.getElementById("mainform").appendChild(newmsg);
						document.getElementById('mainform').style.transform = "translateY("+(document.getElementById('mainform').offsetHeight *-1 +document.getElementById('chatform').offsetHeight)+"px)";
						openChat();
					}
					lastopmsgtime = result[1].lastopmsgtime;
					//alert('result[1].operators');
					if(document.getElementById('mydiv1').style.display=='none'){
						if(result[1].operators == "online"){
							document.getElementById('weonline').style.display='block';
							document.getElementById('weoffline').style.display='none';
						}else{
							document.getElementById('weonline').style.display='none';
							document.getElementById('weoffline').style.display='block';
						}
					}
					
					if(result[1].operators == "online"){
						onlinestatus = true;
						document.getElementById('onoffheader').innerText='Напишите ваше сообщение';
					}else{
						onlinestatus = false;
						if(document.getElementById('OfflineMsgSended').style.display=='block')
						document.getElementById('onoffheader').innerText='Сообщение отправлено';
					    else
						document.getElementById('onoffheader').innerText='Оставьте сообщение';
					}
					
					OpID = result[1].opid;
					if(result[1].optyping == 1)$('#opistype').text('Оператор набирает сообщение...');else $('#opistype').text('');
					if(result[1].name !== null){
						document.getElementById("opjpg").src = 'https://nachalosaita.itgroup.kz/img/'+result[1].jpgname;
						document.getElementById("opname").innerHTML = '&nbsp;'+result[1].name;
						document.getElementById("oppos").innerHTML = '&nbsp;'+result[1].oppos;
						document.getElementById('mydiv').style.display = 'block';
						document.getElementById('mydiv3').style.display = 'none';
					}else
					{
						document.getElementById("opjpg").src = '';
						document.getElementById("opname").innerHTML = '&nbsp;';						
						document.getElementById('mydiv').style.display = 'none';
						document.getElementById('mydiv3').style.display = 'block';
					}
				}
			});
		});
		if(LastChatMessage !== document.getElementById("message").value){
			if(LastChatStatusMessage !== 1){		
				$.ajax({
					type: 'POST', url: 'https://nachalosaita.itgroup.kz/sitesusers/setstatususrtying.php',  
					data: { 'usrtyping' : '1','cookies' : getCookie("nachalosaita")}, 
					beforeSend: function(){},
					success: function(data){}
				});
				LastChatStatusMessage = 1;
			}
			
		}else
		if(LastChatStatusMessage !== 2){
			$.ajax({
				type: 'POST', url: 'https://nachalosaita.itgroup.kz/sitesusers/setstatususrtying.php',  
				data: { 'usrtyping' : '0','cookies' : getCookie("nachalosaita")}, 
				beforeSend: function(){},
				success: function(data){}
			});
			LastChatStatusMessage = 2;
		}
		LastChatMessage = document.getElementById("message").value;
		//setTimeout(function(){},1000);
		//alert("MSG");
}

function onWheel(e) {
  e = e || window.event;
  var delta = e.deltaY || e.detail || e.wheelDelta;

  var info = document.getElementById('mainform');
  var y = parseInt(getTranslateY(info))*-1;
  if((y <= (info.offsetHeight-opposite(delta)*15)) && ((y+opposite(delta)*15) >= 0))
  info.style.transform = "translateY("+(parseInt(getTranslateY(info))-opposite(delta)*15)+"px)";
  
  e.preventDefault ? e.preventDefault() : (e.returnValue = false);
}
function getTranslateY(obj)
{
	var style = obj.style,
	transform = style.transform || style.webkitTransform || style.mozTransform || style.msTransform,
	zT = transform.match(/translateY\((-?[0-9]+(px|em|%|ex|ch|rem|vh|vw|vmin|vmax|mm|cm|in|pt|pc))\)/);
	return zT ? zT[1] : '0';
}
function opposite(number) {
	if (number < 0) {
		return 1
	} else {
		return -1
	}
}

function OnChangeFileClick() {
	
    var file_data = $('#file1').prop('files')[0];   
    var form_data = new FormData();                  
    form_data.append('file', file_data);
    //alert(form_data);                             
    $.ajax({
        url: 'https://nachalosaita.itgroup.kz/sitesusers/upload.php', 
        dataType: 'text',  
        cache: false,
        contentType: false,
        processData: false,
		data:form_data,
        type: 'post',
        success: function(php_filename){
            
			var newmsg = document.createElement("DIV");
			var fileName = document.getElementById("file1").value.split('\\')[document.getElementById("file1").value.split('\\').length - 1];
			newmsg.innerHTML = 'Файл: <a target="_blank" href="https://nachalosaita.itgroup.kz/uploads/'+php_filename+'">'+fileName+'</a>';newmsg.className ="style9";
			document.getElementById("mainform").appendChild(newmsg);
			document.getElementById('mainform').style.transform = "translateY("+(document.getElementById('mainform').offsetHeight *-1 +document.getElementById('chatform').offsetHeight)+"px)";
			$.ajax({
				type: 'POST', url: 'https://nachalosaita.itgroup.kz/sitesusers/loginuser.php',  
				data: { 'name' : UserName,'phone' : document.getElementById("userphone").value,'email' : UserEmail,'watch' : document.title,'cookies' : getCookie("nachalosaita"), 'msg' : 'Файл: <a target="_blank" href="https://nachalosaita.itgroup.kz/uploads/'+php_filename+'">'+fileName+'</a>', 'lastopmsgtime' : lastopmsgtime, 'opid' : OpId }, 
				beforeSend: function(){},
				success: function(data){}
			});
		}
     });
};

function getDomain(url) {
    var a=document.createElement('a');
    a.href=url;
    return a.hostname;
}
function NameValidator(){
	UserName=document.getElementById("username").value;
	if(document.getElementById("username").value=='')document.getElementById("username").style.border = "1px solid red";
	else document.getElementById("username").style.border = "1px solid #D2D4D8";
}
function EmailValidator(){
	UserEmail=document.getElementById("useremail").value;
	if(document.getElementById("useremail").value=='')document.getElementById("useremail").style.border = "1px solid red";
	else document.getElementById("useremail").style.border = "1px solid #D2D4D8";
}
function PhoneValidator(){
	UserPhone=document.getElementById("userphone").value;
}
function NameValidator1(){
	UserName=document.getElementById("username1").value;
	if(document.getElementById("username1").value=='')document.getElementById("username1").style.border = "1px solid red";
	else document.getElementById("username1").style.border = "1px solid #D2D4D8";
}
function EmailValidator1(){
	UserEmail=document.getElementById("useremail1").value;
	if(document.getElementById("useremail1").value=='')document.getElementById("useremail1").style.border = "1px solid red";
	else document.getElementById("useremail1").style.border = "1px solid #D2D4D8";
}
function PhoneValidator1(){
	UserPhone=document.getElementById("userphone1").value;
}
var logedIN = false;
var UserName ='';var UserPhone ='';var UserEmail ='';var OpId ='0';
function checkTextarea(e){
	if(!logedIN){
		//document.getElementById('chatform').style.height ="120px";
		document.getElementById('chatform').style.height = (window.innerHeight -document.getElementById('mydiv1').offsetTop -255-180)+'px';
		if(onlinestatus){
			document.getElementById('NeedUserData').style.display ="block";
			document.getElementById('OnlineUserData').style.display ="block";
			document.getElementById('OfflineUserData').style.display ="none";
		}else
		{
			document.getElementById('NeedUserData').style.display ="none";
			document.getElementById('OnlineUserData').style.display ="none";
			document.getElementById('OfflineUserData').style.display ="block";
			document.getElementById('SendBtn').style.display ="block";
		}
		
	}
    var code = (e.keyCode ? e.keyCode : e.which);
    if (code == 13) {
		var str = document.getElementById('message').value;
		var re = /'/gi;
		document.getElementById('message').value = str.replace(re, '`');
		document.getElementById('message').value = str.substring(0,str.length-1);
		if(document.getElementById("username").value=='')document.getElementById("username").style.border = "1px solid red";
		if(document.getElementById("useremail").value=='')document.getElementById("useremail").style.border = "1px solid red";
		if(document.getElementById("username1").value=='')document.getElementById("username1").style.border = "1px solid red";
		if(document.getElementById("useremail1").value=='')document.getElementById("useremail1").style.border = "1px solid red";
		//if(document.getElementById("message").value=='')document.getElementById("message").style.border = "1px solid red";
		 //  else document.getElementById("message").style.border = "1px solid #D2D4D8";
		if((UserName!=='') && (UserEmail!=='') && (document.getElementById("message").value!=='')){
			//document.getElementById('chatform').style.height ="275px";
			document.getElementById('NeedUserData').style.display ="none";
			if(document.getElementById('OfflineUserData').style.display =="block"){
			   document.getElementById('OfflineMsgSended').style.display ="block";
			   document.getElementById('message').style.display ="none";
			   document.getElementById('imgfile1').style.display ="none";
			   document.getElementById('SendBtn').style.display ="none";
			}
			document.getElementById('OfflineUserData').style.display ="none";
			document.getElementById('chatform').style.height = (window.innerHeight -document.getElementById('mydiv1').offsetTop -255)+'px';
			var newmsg = document.createElement("DIV");
			//newmsg.innerText = document.getElementById('message').value;
						var t = new Date();
						newmsg.title =t.toLocaleString();

						newmsg.innerHTML = '<font size="2" color="#F0F0F0" face="Arial">'+t.toLocaleString()+'</font><br>'+'<b>'+UserName+'</b><br>'+document.getElementById('message').value;
			
			newmsg.className ="style9";
			document.getElementById("mainform").appendChild(newmsg);
			document.getElementById('mainform').style.transform = "translateY("+(document.getElementById('mainform').offsetHeight *-1 +document.getElementById('chatform').offsetHeight)+"px)";
			$(document).ready(function(){
				
				$.ajax({
					type: 'POST', url: 'https://nachalosaita.itgroup.kz/sitesusers/loginuser.php',  
					data: { 'name' : UserName,'phone' : document.getElementById("userphone").value,'email' : UserEmail,'watch' : document.title,'cookies' : getCookie("nachalosaita"), 'msg' : document.getElementById("message").value, 'lastopmsgtime' : lastopmsgtime, 'opid' : OpId }, 
					beforeSend: function(){},
					success: function(data){ 
						var result = $.parseJSON(data);
						if(result[0].cookies == getCookie("nachalosaita"))logedIN=true;
						document.getElementById("message").value='';
					}
				});
			});			
			
		}
    }		
	
}
function SendKey(){
   var keyboardEvent = new KeyboardEvent('keydown',{code:'Enter',key:'Enter',charKode:13,keyCode:13,view:window});
   checkTextarea(keyboardEvent);
}
var TimerID;
var preloginOk = false;
function Timer1(){
	if(!preloginOk){
		preloginOk = true;
		var elem = document.getElementById('chatform');
		//while((typeof elem === 'undefined') | (elem === null)) {// || elem === null
		//	elem = document.getElementById('chatform');
		//}
		if (elem.addEventListener) {
		  if ('onwheel' in document) {
			// IE9+, FF17+
			elem.addEventListener("wheel", onWheel);
		  } else if ('onmousewheel' in document) {
			// устаревший вариант события
			elem.addEventListener("mousewheel", onWheel);
		  } else {
			// Firefox < 17
			elem.addEventListener("MozMousePixelScroll", onWheel);
		  }
		} else { // IE8-
		  elem.attachEvent("onmousewheel", onWheel);
		}
		//var referrer = new URL(document.referrer);
		

			
			$.ajax({
				type: 'POST', url: 'https://nachalosaita.itgroup.kz/sitesusers/preloginuser.php',  
				data: { 'cookies' : getCookie("nachalosaita"), 'refferer' : getDomain(document.referrer), 'watch' : document.title, 'urlsite' : window.location.hostname }, 
				beforeSend: function(){},
				success: function(data){ 
					var result = $.parseJSON(data);
					for(var i in result[0]){
						var newmsg = document.createElement("DIV");
						var newstr = result[0][i].msg;
						newstr = newstr.replace('&lt;', '<');newstr = newstr.replace('&gt;', '>');
						var t = new Date(result[0][i].dtime);
						t.setTimezoneOffset(t.getTimezoneOffset()*2);
						newmsg.title =t.toLocaleString();
						var color="A0A0A0";if(result[0][i].toop == 1) color="F0F0F0";
						newmsg.innerHTML = '<font size="2" color="#'+color+'" face="Arial">'+t.toLocaleString()+'</font><br>'+newstr;
						if(result[0][i].toop == 0)newmsg.className ="style8";else newmsg.className ="style9";
						document.getElementById("mainform").appendChild(newmsg);

					}
					if(result[1].cookies != getCookie("nachalosaita"))setCookie("nachalosaita",result[1].cookies,365);
					document.getElementById('mainform').style.transform = "translateY("+(document.getElementById('mainform').offsetHeight *-1 +document.getElementById('chatform').offsetHeight)+"px)";
					window.lastopmsgtime = result[1].lastopmsgtime;
					//alert(lastopmsgtime);
					
					UserName =result[1].name;UserEmail =result[1].email; if(UserName.length>0)logedIN=true;
				}
			});
				
	}
	if(lastopmsgtime!=='')doupdate();
//alert(window.lastopmsgtime);

}
function mainchat2(){
	var link = document.createElement("link");
	link.setAttribute("rel", "stylesheet");
	link.setAttribute("type", "text/css");
	link.setAttribute("href", 'https://nachalosaita.itgroup.kz/css/c.css');
	document.getElementsByTagName("head")[0].appendChild(link);
	chatX = window.innerWidth-350;
	chatY = window.innerHeight-550;

    var maindiv = document.createElement('DIV');
    maindiv.className="style1";
    maindiv.id="mydiv1";
	maindiv.style.display='none';
	maindiv.innerHTML = '<div class="style3"><a href="https://itgroup.kz/hamburger-uslugi/onlajn-konsultant.html" target="_blank"><div class="styleL"></div></a></div><div id="mydiv" class="style2" style="display:none;" onmousemove="dragElement(document.getElementById(\'mydiv\'))"><table border=0 style="padding-top: 0px;" height="65"><tr><td><img class="empty1" id="opjpg" border="0" src="" style="border-radius: 50%;" ></td><td style="padding-left: 0px;"><div id="opname" style="font-family: Arial; color: #6ECF8E;font-size: 15px;">&nbsp;</div><div style="font-family: Arial; color: #000000;font-size: 13px;" id="oppos">&nbsp;Консультант</div></td><td width="100%" align="right"><div style="left:-25px;position: relative;color: #B5B5B5;" onClick="closeChat()" id="mydiv2">X</div></td></tr></table></div><div id="mydiv3" class="style2" style="display:block;" onmousemove="dragElement(document.getElementById(\'mydiv3\'))"><table border=0 style="padding-top: 0px;" height="65" width="100%"><tr><td valign="middle" style="font-size: 18px; color: #6ECF8E;">&nbsp;<span id="onoffheader">Напишите ваше сообщение</span></td><td width="35" align="left" valign="middle"><div class="style4" onClick="closeChat()" id="mydiv4">X</div></td></tr></table></div><table border=0 width="100%" style="margin-top:-10px"><tr><td valign="bottom" align="right" width="50%" class="style5">Чат предоставлен</td><td valign="bottom" align="left"><a href="https://itgroup.kz/hamburger-uslugi/onlajn-konsultant.html" target="_blank"><img border="0" src="https://nachalosaita.itgroup.kz/img/l1.png"></a></td></tr></table><div id="OnlineUserData"><div class="style6" id="NeedUserData" style="display:none;"><br>Представьтесь пожалуйста<br><br><input type="text" placeholder="Имя" minlength="4" style="width:282px;height:20px; padding-left: 15px;border: 1px solid #D2D4D8;font-size:12px;" id="username" onchange="NameValidator();"><br><br><input type="tel" placeholder="Телефон" style="width:282px;height:20px; padding-left: 15px;border: 1px solid #D2D4D8;font-size:12px;" id="userphone" onchange="PhoneValidator();"><br><br><input type="email" placeholder="Email" style="width:282px;height:20px; padding-left: 15px;border: 1px solid #D2D4D8;font-size:12px;" id="useremail" onchange="EmailValidator();"></div><div class="style7" id="chatform"><div id="mainform" style="transform: translateY(0px);" height="100%;"></div></div><div class="style10" id="opistype"></div></div><div id="OfflineUserData" style="display:none;"><div class="style61"><br><br><br><br><p style="margin-left:20px;font-family: Arial; color: #656565; font-size: 12px;">Оставьте своё сообщение в этой форме, и мы обязательно ответим</p><br><center><input type="text" placeholder="Имя" minlength="4" style="width:282px;height:20px; padding-left: 15px;border: 1px solid #D2D4D8;font-size:12px;" id="username1" onchange="NameValidator1();"><br><br><input type="email" placeholder="Email" style="width:282px;height:20px; padding-left: 15px;border: 1px solid #D2D4D8;font-size:12px;" id="useremail1" onchange="EmailValidator1();"><br><br><input type="tel" placeholder="Телефон" style="width:282px;height:20px; padding-left: 15px;border: 1px solid #D2D4D8;font-size:12px;" id="userphone1" onchange="PhoneValidator1();"></center></div></div><textarea type="text" id="message" class="form-control1" name="message" placeholder="Задайте нам вопрос. \r\nДля отправки нажмите Enter" spellcheck="true" onkeyup="checkTextarea(event)"></textarea><div id="OfflineMsgSended" align="center" style="display:none;height:425px;text-align: center;"><br><br><br><br><br><br><br><p style="color:#35C267;text-align:center;font-family: Arial;font-size:13px;">Спасибо за ваше сообщение!</p><p style="color:#000000;text-align:center;font-family: Arial;font-size:12px;">В ближайшее время мы обязательно<br> свяжемся с вами.</p><br><table border="0" align="center"><tr><td align="center"><div align="center" style="height:19px;width:115px;background:#3DC76F;color:#FFFFFF;text-align:center;font-family: Arial;font-size:14px;padding-top:4px;margin-top:3px;margin-right:5px;" onclick="closeChat();">ЗАКРЫТЬ</div></td></tr></table></div><div class="style11"><img border="0" src="https://nachalosaita.itgroup.kz/img/clip.png" id="imgfile1" title="Загрузить вайл" onclick="$(\'#file1\').trigger(\'click\');"><input type="file" name="file1" id="file1" style="display: none;" onchange="OnChangeFileClick();"><div style="float:right;height:19px;width:115px;background:#3DC76F;color:#FFFFFF;text-align:center;font-family: Arial;font-size:14px;padding-top:4px;margin-top:3px;margin-right:5px;display:none;" onclick="SendKey();" id="SendBtn">ОТПРАВИТЬ</div></div>';
    var mainbtn = document.createElement('DIV');
    mainbtn.className="style0";
    mainbtn.id="buttonchat";
	mainbtn.onclick=openChat;
	mainbtn.innerHTML = '<div id="weonline" style="display:none;"><table border=0 style="padding-top: 0px;margin-left: 25px;" height="55"><tr><td valign="middle" style="font-family: Arial; color: #2D2D2D;font-size: 16px;">Напишите нам, мы <font style="font-family: Arial; color: #34B964;font-size: 16px;">онлайн!</font></td><td valign="middle" align="center" width="65"><img border="0" src="https://nachalosaita.itgroup.kz/img/weonline.png"></td></tr></table></div><div id="weoffline" style="display:block;"><table border=0 style="padding-top: 0px;margin-left: 25px;" height="55"><tr><td valign="middle" style="font-family: Arial; color: #2D2D2D;font-size: 16px;">Оставьте нам сообщение</td><td valign="middle" align="center" width="85"><img border="0" src="https://nachalosaita.itgroup.kz/img/weoffline.png"></td></tr></table></div>';
    link.onload = function(){
		document.getElementsByTagName("body")[0].appendChild(maindiv);
		document.getElementsByTagName("body")[0].appendChild(mainbtn);
		TimerID = setInterval(Timer1, 1000);
	}
	

	
}