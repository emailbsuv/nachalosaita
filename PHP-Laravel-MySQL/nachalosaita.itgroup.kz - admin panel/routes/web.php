<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});
Route::post('login', 'LoginController@login');
Route::get('login', ['uses' => 'LoginController@login','as' => 'welcome']);
Route::get('home', ['uses' => 'HomeController@index','as' => 'home.show']);
Route::get('home_sites', ['uses' => 'HomeSitesController@index','as' => 'home_sites.show']);
Route::get('home_operators', ['uses' => 'HomeOperatorsController@index','as' => 'home_operators.show']);
Route::post('applysiteops', 'ApplySiteOpsController@index');
Route::post('addoperator', 'AddOperatorController@index');
Route::get('settingsoperator/{id}', 'SettingsOperatorController@index');
Route::post('settingsoperator/{id}', 'SettingsOperatorController@savesettings');
Route::post('deloperator/{id}', 'SettingsOperatorController@deloperator');
Route::get('callhistoryoperator/{id}', ['uses' => 'CallHistoryOperatorController@index','as' => 'callhistoryoperator.show']);
Route::get('callhistoryview/{opid}/{id}', 'CallHistoryOperatorController@view');
Route::get('callhistorydelete/{opid}/{id}', 'CallHistoryOperatorController@delete');
Route::get('callhistoryoperatorsite/{siteid}', 'CallHistoryOperatorController@viewsite');
Route::get('settingssites/{siteid}', 'SettingsSitesController@setup');