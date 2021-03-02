<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
//use App\Users;
use DB;
//use Illuminate\Support\Facades\Cookie;

class LoginController extends Controller
{
    public function login(Request $request, Response $response){
//		return view('name', ['urls' => Users::get_news()]);
		$users = DB::table('operators')->where([
			['login', '=', $request->email],
			['password', '=', $request->passwd],
		])->first();
		$cookie = $this->randomCookie();
		DB::table('operators')
		->where([
		['login', '=', $request->email],
		['password', '=', $request->passwd],
		])->update(['cookies' => $cookie]);
		if(isset($users)){
		  if($users->id == 1)
			return redirect('home')->withCookie(cookie()->forever('user1',$cookie));
			else 
			return redirect('home_sites')->withCookie(cookie()->forever('user1',$cookie));
		}else
		return view('welcome',['errors' => 'Такой пользователь не существует']);

//		return redirect()->route('welcome.show',  ['product' => '1']);
    }
	private function randomCookie() {
		$alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
		$cookie = array();
		$alphaLength = strlen($alphabet) - 1;
		for ($i = 0; $i < 10; $i++) {
			$n = rand(0, $alphaLength);
			$cookie[] = $alphabet[$n];
		}
		return implode($cookie);
	}

}
