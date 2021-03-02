<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class SettingsSitesController extends Controller
{
    public function setup(Request $request, $siteid){
		$operator = DB::table('operators')->where([['cookies', '=', $request->cookie('user1')],])->first();
		if(!isset($operator))return redirect('/');
		
		$sitesproperties = DB::select(DB::raw("SELECT * FROM sitesproperties WHERE site='".$siteid."'"));

		return view('settings_sites_setup',["sitesproperties"=>$sitesproperties,"opname"=>$operator->name,"opid"=>$operator->id]);
    }
}
