<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Illuminate\Support\Arr;

class HomeSitesController extends Controller
{
    public function index(Request $request){
		$operator = DB::table('operators')->where([['cookies', '=', $request->cookie('user1')],])->first();
		if(!isset($operator))return redirect('welcome');
		$sites = DB::table('opsites')->where([['opid', '=', $operator->id],])->get();
		$i=1;
		$oplist=collect();$oplistarr=array();
		foreach ($sites as $site){
			$accepted = DB::select(DB::raw("SELECT count( DISTINCT usersopsmsgs.userid) as sid FROM sitesusers LEFT JOIN usersopsmsgs ON (usersopsmsgs.userid=sitesusers.id AND usersopsmsgs.status=1)WHERE sitesusers.urlsite='".$site->site."' "));
			$notaccepted = DB::select(DB::raw("SELECT count( DISTINCT usersopsmsgs.userid) as sid FROM sitesusers LEFT JOIN usersopsmsgs ON (usersopsmsgs.userid=sitesusers.id AND usersopsmsgs.status=0)WHERE sitesusers.urlsite='".$site->site."' "));
			$siteops = DB::select(DB::raw("SELECT operators.jpgname,operators.id,operators.name,operators.position FROM operators LEFT JOIN opsites ON opsites.opid=operators.id WHERE opsites.site='".$site->site."' "));
			//var_dump($siteops);
			$ops = '';
			foreach ($siteops as $op){
				$ops .= '<div id="div'.substr("00".$i, -3)."_".$op->id.'" style="font-family: Arial; background: #4D6373; padding:5px;color:#FFFFFF;font-size: 11px;display:none">'.$op->name.'<br><span style="font-family: Arial; background: #4D6373; color:#37B965;font-size: 11px;">'.$op->position.'</span></div><img id="img'.substr("00".$i, -3)."_".$op->id.'" border="0" src="/img/'.$op->jpgname.'" onmousemove="ShowHint(\''.substr("00".$i, -3)."_".$op->id.'\')" onmouseout="HideHint(\''.substr("00".$i, -3)."_".$op->id.'\')" style="cursor: pointer;"> ';
				if(!in_array([$op->name,$op->jpgname,$op->position,$op->id],$oplistarr)){
					array_push($oplistarr,[$op->name,$op->jpgname,$op->position,$op->id]);
				}
				$i++;
			}
			//if(isset($accepted[0]->sid))
			$site->accepted = $accepted[0]->sid;
			$site->notaccepted = $notaccepted[0]->sid;
			$site->ops = $ops;
			//$sites1[] = $site->site;
			
			//else $site->accepted = "0";
		}
		$oplist->put('op',$oplistarr);
		//var_dump($oplist);
		//$sitelist->put('site' , $sites1);
		return view('home_sites',["sites"=>$sites , "oplist"=>$oplist,"opname"=>$operator->name,"opid"=>$operator->id]);
    }
}
