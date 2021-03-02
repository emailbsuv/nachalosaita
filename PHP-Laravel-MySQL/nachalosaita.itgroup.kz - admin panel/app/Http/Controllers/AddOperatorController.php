<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class AddOperatorController extends Controller
{
    public function index(Request $request){
		if(!empty($request->input('name'))){
			$smid = DB::select(DB::raw("SELECT max(id) as mid FROM operators"));
			$mid = $smid[0]->mid + 1;
			$admin = 0;
			if($request->input('admin')=="true") $admin = 1;
			DB::select(DB::raw("INSERT INTO operators VALUES (".$mid.",'".$request->input('name')."','foto.jpg','','".$request->input('email')."','".$request->input('password')."','Отошёл','2020-02-02 02:02:02','Консультант',0,0,0,0,0,0,0,0,".$admin.")"));
			$smid = DB::select(DB::raw("SELECT max(id) as mid FROM opsites"));
			$mid2 = $smid[0]->mid + 1;
			DB::select(DB::raw("INSERT INTO opsites VALUES (".$mid2.",".$mid.",'".$request->input('site')."')"));
		}
		return "ok";
    }
}
