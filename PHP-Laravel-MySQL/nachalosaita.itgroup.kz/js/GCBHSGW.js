function mainchat(){
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src  = 'https://nachalosaita.itgroup.kz/js/jquery-3.5.1.min.js';
    document.getElementsByTagName("head")[0].appendChild(script);
	script.onload = function() {

		var script2 = document.createElement('script');
		script2.type = 'text/javascript';
		script2.src  = 'https://nachalosaita.itgroup.kz/js/mainchat.js';
		document.getElementsByTagName("head")[0].appendChild(script2);
		script2.onload = function() {	
			mainchat2();
		}	
	}	
}