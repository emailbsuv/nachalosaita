<?php

namespace App;

use DB;

use Illuminate\Database\Eloquent\Model;

class Users extends Model
{
    //
  public static function get_news()
  {
/*$array = [];
$query = DB::connection()->getPdo()->query("select subject from news where id=3");
do {
         $data = $query->fetchAll();//PDO::FETCH_ASSOC);
          if ($data) {      
            array_push($array, $data);
          }
  } while ($query->nextRowset());
return var_dump($array);
*/
    return DB::table('news')->select('*')->where('id',3)->get();
  }
}
