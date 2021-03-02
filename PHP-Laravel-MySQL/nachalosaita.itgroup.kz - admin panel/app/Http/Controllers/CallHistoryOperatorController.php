<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class CallHistoryOperatorController extends Controller
{
    public function index(Request $request, $id){
		$operator = DB::table('operators')->where([['cookies', '=', $request->cookie('user1')],])->first();
		if(!isset($operator))return redirect('welcome');

		$msgs = DB::select(DB::raw("SELECT DISTINCT userid,operators.name,operators.status,operators.jpgname,operators.lastvisitdtime,sitesusers.name as uname,sitesusers.ip as uip FROM usersopsmsgs LEFT JOIN operators ON operators.id=usersopsmsgs.opid LEFT JOIN sitesusers ON sitesusers.id=usersopsmsgs.userid WHERE usersopsmsgs.opid=".$id." AND usersopsmsgs.toop=1 ORDER BY userid DESC"));
		
		foreach ($msgs as $msg){
			$dtime = DB::select(DB::raw("SELECT MIN(usersopsmsgs.dtime) as mindtime, MAX(usersopsmsgs.dtime) as maxdtime FROM usersopsmsgs WHERE userid='".$msg->userid."' AND usersopsmsgs.opid='".$id."'"));
			$msgcnt = DB::select(DB::raw("SELECT COUNT(usersopsmsgs.id) as cid FROM usersopsmsgs WHERE userid='".$msg->userid."' AND usersopsmsgs.opid='".$id."'"));
			$msg->dtime = date("d-m-Y H:i:s",strtotime($dtime[0]->mindtime));
			$msg->time = $this->mytime(strtotime($dtime[0]->maxdtime)-strtotime($dtime[0]->mindtime));
			$msg->msgcnt = $msgcnt[0]->cid;
			if($msg->uname == '')$msg->uname=$msg->uip;
			$status = '<span style="font-family:Arial;color:#70E536;font-size:13px;">В сети</span>';
			if($msg->status == "Отошёл") $status = '<span style="font-family:Arial;color:#E57036;font-size:13px;">Отошёл</span>';
			if((strtotime(date("Y-m-d H:i:s")) - strtotime($msg->lastvisitdtime))>10)
				$status = '<span style="font-family:Arial;color:#E57036;font-size:13px;">Отошёл</span>';
			$msg->status = $status;
			$msg->opid = $id;
		}

		return view('callhistory_operators',["msgs"=>$msgs,"opname"=>$operator->name,"opid"=>$operator->id]);
    }
    public function view(Request $request, $opid, $id){
		$operator = DB::table('operators')->where([['cookies', '=', $request->cookie('user1')],])->first();
		if(!isset($operator))return redirect('welcome');

		$op = DB::select(DB::raw("SELECT name,jpgname FROM operators WHERE id=".$opid));
		$user = DB::select(DB::raw("SELECT * FROM sitesusers WHERE id=".$id));
		$msgs = DB::select(DB::raw("SELECT * FROM usersopsmsgs WHERE opid=".$opid." AND userid=".$id." ORDER BY dtime ASC"));
		
		$usermintime = DB::select(DB::raw("SELECT MIN(dtime) as mdtime FROM usersopsmsgs WHERE userid='".$id."' AND usersopsmsgs.opid='".$opid."' AND toop=1"));
		$opmintime = DB::select(DB::raw("SELECT MIN(dtime) as mdtime FROM usersopsmsgs WHERE userid='".$id."' AND usersopsmsgs.opid='".$opid."' AND toop=0 AND dtime>'".$usermintime[0]->mdtime."'"));
		$waittime = $this->mytime(strtotime($opmintime[0]->mdtime)-strtotime($usermintime[0]->mdtime));
		
		foreach ($msgs as $msg){
			$msg->time = date("H:i",strtotime($msg->dtime));
			$msg->dtime = date("d-m-Y",strtotime($msg->dtime));
			if($msg->toop == "0")$msg->bgcolor = "F2F2F2"; else $msg->bgcolor = "FFFFFF";
		}

		return view('callhistory_operators_view',["msgs"=>$msgs,"op"=>$op,"user"=>$user,"waittime"=>$waittime, "referer"=>$request->headers->get('referer'),"opname"=>$operator->name,"opid"=>$operator->id]);
    }
    public function viewsite(Request $request, $siteid){
		$operator = DB::table('operators')->where([['cookies', '=', $request->cookie('user1')],])->first();
		if(!isset($operator))return redirect('welcome');

		$msgs = DB::select(DB::raw("SELECT DISTINCT userid,operators.name,operators.status,operators.jpgname,operators.lastvisitdtime,usersopsmsgs.opid,sitesusers.name as uname,sitesusers.ip as uip FROM usersopsmsgs LEFT JOIN operators ON operators.id=usersopsmsgs.opid LEFT JOIN sitesusers ON sitesusers.id=usersopsmsgs.userid WHERE usersopsmsgs.opid<>0 AND usersopsmsgs.toop=1 AND sitesusers.urlsite='".$siteid."' ORDER BY userid DESC"));
		
		foreach ($msgs as $msg){
			$dtime = DB::select(DB::raw("SELECT MIN(usersopsmsgs.dtime) as mindtime, MAX(usersopsmsgs.dtime) as maxdtime FROM usersopsmsgs WHERE userid='".$msg->userid."' AND usersopsmsgs.opid='".$msg->opid."'"));
			$msgcnt = DB::select(DB::raw("SELECT COUNT(usersopsmsgs.id) as cid FROM usersopsmsgs WHERE userid='".$msg->userid."' AND usersopsmsgs.opid='".$msg->opid."'"));
			$msg->dtime = date("d-m-Y H:i:s",strtotime($dtime[0]->mindtime));
			$msg->time = $this->mytime(strtotime($dtime[0]->maxdtime)-strtotime($dtime[0]->mindtime));
			$msg->msgcnt = $msgcnt[0]->cid;
			if($msg->uname == '')$msg->uname=$msg->uip;
			$status = '<span style="font-family:Arial;color:#70E536;font-size:13px;">В сети</span>';
			if($msg->status == "Отошёл") $status = '<span style="font-family:Arial;color:#E57036;font-size:13px;">Отошёл</span>';
			if((strtotime(date("Y-m-d H:i:s")) - strtotime($msg->lastvisitdtime))>10)
				$status = '<span style="font-family:Arial;color:#E57036;font-size:13px;">Отошёл</span>';
			$msg->status = $status;
			//$msg->opid = 0;
		}

		return view('callhistory_operators',["msgs"=>$msgs,"opname"=>$operator->name,"opid"=>$operator->id]);
    }
    public function delete(Request $request, $opid, $id){
		$operator = DB::table('operators')->where([['cookies', '=', $request->cookie('user1')],])->first();
		if(!isset($operator))return redirect('welcome');

		DB::select(DB::raw("DELETE FROM usersopsmsgs WHERE opid=".$opid." AND userid=".$id));
		
		return redirect()->route('callhistoryoperator.show',  ['id' => $opid]);
    }
	private function mytime($time1){
		$tmp="";
		$time = new \DateTime('@'.($time1+0));
		$h = $time->format('H')+0;$i = $time->format('i')+0;$s = $time->format('s')+0;
		if($h>0)$tmp.=$h."час. ";if($i>0)$tmp.=$i."мин. ";if($s>0)$tmp.=$s."сек.";
		return $tmp;
	}
}
