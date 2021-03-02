<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class SettingsOperatorController extends Controller
{
    public function index(Request $request, $id){
		$operator = DB::table('operators')->where([['cookies', '=', $request->cookie('user1')],])->first();
		if(!isset($operator))return redirect('welcome');
		
		$op = DB::select(DB::raw("SELECT * FROM operators WHERE id='".$id."'"));
		//$opsites = DB::select(DB::raw("SELECT * FROM opsites WHERE opid='".$id."'"));
		$opsites = DB::table('opsites')->where([['opid', '=', $id],])->get();
		$i=0;
		foreach ($opsites as $site){
			if((((int)($i/2))*2) == $i)
			$site->bgcolor="F2F2F2"; else $site->bgcolor="FFFFFF";
			$i++;
		}

		return view('settings_operators',["operator"=>$op, "opsites"=>$opsites,"opname"=>$operator->name,"opid"=>$operator->id]);
    }
    public function savesettings(Request $request, $id){
		$operator = DB::table('operators')->where([['cookies', '=', $request->cookie('user1')],])->first();
		if(!isset($operator))return redirect('welcome');
		
		$needfoto = true;
		if(!isset($_FILES["file"]["name"])){
			$_FILES["file"]['tmp_name'] = '';
			$_FILES["file"]['type'] = '';
			$needfoto = false;
		}
			$uploadedfile = $_FILES["file"]['tmp_name'];
			$extension = strtolower(str_replace("image/","",$_FILES["file"]['type']));
			if ((($extension != "jpg") && ($extension != "jpeg") && ($extension != "png") && ($extension != "gif"))){
				$_FILES["file"]['tmp_name'] = public_path()."/img/foto.jpg";
				$extension="jpg";
			} 
			$needname = true;
			while($needname){
				$needname = false;
				$newname = rand(111111,999999).".jpg";
				$root = scandir(public_path().'/img/');
				foreach($root as $value) if($value === $newname) $needname = true;
			}
			
			if($extension=="jpg" || $extension=="jpeg" ){
				$uploadedfile = $_FILES["file"]['tmp_name'];
				$src = imagecreatefromjpeg($uploadedfile);
			}else if($extension=="png"){
				$uploadedfile = $_FILES["file"]['tmp_name'];
				$src = imagecreatefrompng($uploadedfile);
			}else{
				$uploadedfile = $_FILES["file"]['tmp_name'];
				$src = imagecreatefromgif($uploadedfile);
			}
			list($width,$height)=getimagesize($uploadedfile);

			$newwidth=32;
			$newheight=32;
			$tmp=imagecreatetruecolor($newwidth,$newheight);

			imagecopyresampled($tmp,$src,0,0,0,0,$newwidth,$newheight, $width,$height);

			$filename = public_path()."/img/".$newname;

			$addsql = '';
			if($needfoto){
				imagejpeg($tmp,$filename,100);
				$f = DB::select(DB::raw("SELECT jpgname FROM operators WHERE id=".$id));
				if($f[0]->jpgname != 'foto.jpg'){
					$root = scandir(public_path().'/img/');
					foreach($root as $value) 
					if($value === $f[0]->jpgname)unlink(public_path().'/img/'.$f[0]->jpgname);
				}
				$addsql .= ",jpgname='".$newname."'";
			}
			if($request->input('admin')=='true')$addsql .= ',admin=1'; else $addsql .= ',admin=0';
			
			DB::select(DB::raw("UPDATE operators SET name='".$request->input('name')."',login='".$request->input('email')."',password='".$request->input('password')."',position='".$request->input('position')."'".$addsql." WHERE id=".$id));

			DB::select(DB::raw("DELETE FROM opsites WHERE opid=".$id));
			$departments = DB::select(DB::raw("SELECT DISTINCT name FROM sitesdepartment WHERE opid=".$id));
			
			foreach($request->input('sites') as $value){
				if($value!=null){
					$smid = DB::select(DB::raw("SELECT max(id) as mid FROM opsites"));
					$mid = $smid[0]->mid + 1;
					DB::select(DB::raw("INSERT INTO opsites VALUES (".$mid.",".$id.",'".$value."')"));
					foreach($departments as $department){
						if($department->name == $value)$department->name=null;
					}
				}
			}
			foreach($departments as $department){
				if($department->name != null)DB::select(DB::raw("DELETE FROM sitesdepartment WHERE opid=".$id." AND name='".$department->name."'"));
			}
			
			imagedestroy($src);
			imagedestroy($tmp);		
		
		return 'ok';
    }
    public function deloperator(Request $request, $id){
		$operator = DB::table('operators')->where([['cookies', '=', $request->cookie('user1')],])->first();
		if(!isset($operator))return redirect('welcome');
		
		DB::select(DB::raw("DELETE FROM opsites WHERE opid=".$id));
		DB::select(DB::raw("DELETE FROM sitesdepartment WHERE opid=".$id));
		DB::select(DB::raw("DELETE FROM operators WHERE id=".$id));

		return 'ok';
    }
}
