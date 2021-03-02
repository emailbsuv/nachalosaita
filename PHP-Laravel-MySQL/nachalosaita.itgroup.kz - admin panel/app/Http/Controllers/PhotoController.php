<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Users;

class PhotoController extends Controller
{
    //
    public function index(){
return view('name', ['urls' => Users::get_news()]);
//	return view('name',['name' => 'Samantha']);
//	return view('name');
    }
    public function store(Request $request){
//return view('name', ['urls' => Users::get_news()]);
//	return view('name',['name' => 'Samantha']);
//	return view('name');
return redirect()->route('welcome.show',  ['product' => '1']);
    }
}
