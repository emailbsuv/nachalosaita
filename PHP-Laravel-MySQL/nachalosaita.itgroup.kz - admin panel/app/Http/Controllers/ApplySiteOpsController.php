<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class ApplySiteOpsController extends Controller
{
    public function index(Request $request){
		DB::select(DB::raw("DELETE FROM opsites WHERE site='".$request->input('site')."' "));
		if(!empty($request->input('ops'))){
			for($i=0;$i<count($request->input('ops'));$i++){
				$smid = DB::select(DB::raw("SELECT max(id) as mid FROM opsites"));
				$mid = $smid[0]->mid + 1;
				DB::select(DB::raw("INSERT INTO opsites VALUES (".$mid.",".$request->input('ops')[$i].",'".$request->input('site')."')"));
			}
		}
		return "ok";
    }
}
