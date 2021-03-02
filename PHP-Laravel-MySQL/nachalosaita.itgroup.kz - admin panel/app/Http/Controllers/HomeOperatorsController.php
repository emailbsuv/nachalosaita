<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Illuminate\Support\Arr;

class HomeOperatorsController extends Controller
{
    public function index(Request $request){
		$operator = DB::table('operators')->where([['cookies', '=', $request->cookie('user1')],])->first();
		if(!isset($operator))return redirect('welcome');
		$oplist=collect();$oplistarr=array();

		$siteops = DB::select(DB::raw("SELECT DISTINCT operators.id, operators.jpgname,operators.name,operators.status,operators.lastvisitdtime,operators.midmsgtime,operators.day1,operators.day2,operators.day3,operators.day4,operators.day5,operators.day6,operators.day7 FROM operators LEFT JOIN opsites ON opsites.opid=operators.id WHERE opsites.site IN (SELECT site FROM opsites WHERE opid='".$operator->id."') ORDER BY operators.id DESC"));
		$sites = DB::select(DB::raw("SELECT DISTINCT opsites.site FROM opsites LEFT JOIN operators ON opsites.opid=operators.id WHERE opsites.site IN (SELECT site FROM opsites WHERE opid='".$operator->id."') "));
		//var_dump($siteops);
		foreach ($siteops as $op){
			//$accepted = DB::select(DB::raw("SELECT count( DISTINCT usersopsmsgs.userid) as sid FROM usersopsmsgs LEFT JOIN sitesusers ON (usersopsmsgs.userid=sitesusers.id AND usersopsmsgs.status=1)WHERE sitesusers.urlsite IN (SELECT site FROM opsites WHERE opid='".$op->id."') AND usersopsmsgs.opid='".$op->id."'"));
			$accepted = DB::select(DB::raw("SELECT COUNT(DISTINCT userid) as sid FROM usersopsmsgs LEFT JOIN operators ON operators.id=usersopsmsgs.opid LEFT JOIN sitesusers ON sitesusers.id=usersopsmsgs.userid WHERE usersopsmsgs.opid=".$op->id." AND usersopsmsgs.toop=1"));
			$notaccepted = DB::select(DB::raw("SELECT count( DISTINCT usersopsmsgs.userid) as sid FROM usersopsmsgs LEFT JOIN sitesusers ON (usersopsmsgs.userid=sitesusers.id AND usersopsmsgs.status=0)WHERE sitesusers.urlsite IN (SELECT site FROM opsites WHERE opid='".$op->id."') AND usersopsmsgs.opid='".$op->id."'"));
			$status = '<span style="font-family:Arial;color:#70E536;font-size:14px;">В сети</span>';
			if($op->status == "Отошёл") $status = '<span style="font-family:Arial;color:#E57036;font-size:14px;">Отошёл</span>';
			if((strtotime(date("Y-m-d H:i:s")) - strtotime($op->lastvisitdtime))>10)
				$status = '<span style="font-family:Arial;color:#E57036;font-size:14px;">Отошёл</span>';
			array_push($oplistarr,[$op->name,$op->jpgname,$status,$op->id,$accepted[0]->sid,$notaccepted[0]->sid,$this->mytime($op->midmsgtime),[(int)(100/(86400/($op->day1+1))),$this->mytime($op->day1)],[(int)(100/(86400/($op->day2+1))),$this->mytime($op->day2)],[(int)(100/(86400/($op->day3+1))),$this->mytime($op->day3)],[(int)(100/(86400/($op->day4+1))),$this->mytime($op->day4)],[(int)(100/(86400/($op->day5+1))),$this->mytime($op->day5)],[(int)(100/(86400/($op->day6+1))),$this->mytime($op->day6)],[(int)(100/(86400/($op->day7+1))),$this->mytime($op->day7)]]);
		}
		$daylist = array("Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс");
		for($i=0;$i<date("N");$i++){
		$shift = array_shift($daylist);
		array_push($daylist,$shift);}

		$oplist->put('op',$oplistarr);
		return view('home_operators',["oplist"=>$oplist, "daylist"=>$daylist, "sites"=>$sites,"opname"=>$operator->name,"opid"=>$operator->id]);
    }
	private function mytime($time1){
		$tmp="";
		$time = new \DateTime('@'.($time1+0));
		$h = $time->format('H')+0;$i = $time->format('i')+0;$s = $time->format('s')+0;
		if($h>0)$tmp.=$h."час. ";if($i>0)$tmp.=$i."мин. ";if($s>0)$tmp.=$s."сек.";
		return $tmp;
	}
}
