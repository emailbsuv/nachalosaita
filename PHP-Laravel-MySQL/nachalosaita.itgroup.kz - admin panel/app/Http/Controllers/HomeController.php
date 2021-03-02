<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use DB;

class HomeController extends Controller
{
    public function index(Request $request, Response $response){
		$users = DB::table('operators')->where([['cookies', '=', $request->cookie('user1')],])->get();
		if($users->count()==0)return redirect('welcome');
	//	var_dump($request->cookie('user1'));
		return view('home');
    }
}
