<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Панель управления разработчика</title>

        <!-- Fonts -->
        <llink href="https://fonts.googleapis.com/css?family=Nunito:200,600" rel="stylesheet">

        <!-- Styles -->
        <style>
            html, body {
                background-color: #fff;
                color: #636b6f;
                font-family: 'Nunito', sans-serif;
                font-weight: 200;
                height: 100vh;
                margin: 0;
            }

            .full-height {
                height: 100vh;
            }

            .flex-center {
                align-items: center;
                display: flex;
                justify-content: center;
            }

            .position-ref {
                position: relative;
            }

            .top-right {
                position: absolute;
                right: 10px;
                top: 18px;
            }

            .content {
                text-align: center;
            }

            .title {
                font-size: 84px;
            }

            .links > a {
                color: #636b6f;
                padding: 0 25px;
                font-size: 13px;
                font-weight: 600;
                letter-spacing: .1rem;
                text-decoration: none;
                text-transform: uppercase;
            }
            .errors {
                color: #FF6b6f;
                padding-top:15px;
                font-size: 13px;
                font-weight: 600;
                letter-spacing: .1rem;
                text-decoration: none;
                text-transform: uppercase;
            }
label input {
  display: none;
}
label span {
  height: 6px;
  width: 6px;
  border: 1px solid gray;
  display: inline-block;
  position: relative;
  background-color:#FFF;
  vertical-align: middle;
  *overflow: hidden;
  position: relative;
  border-radius:2px;
  padding:3px;
}
[type=checkbox]:checked + span:before {
  content: '\2714';
  position: absolute;
  *overflow: hidden;
  top: -5px;
  left: 0;
  font-size:14px;
  color:green;
}
        </style>
    </head>
    <body>
        <div class="flex-center position-ref full-height">
            <div class="content">
<form method="POST" action="/login" accept-charset="UTF-8" id="form1">
<input type="hidden" name="_token" value="{{ csrf_token() }}">
<img border="0" src="/img/logo_admin.png"><br>
<span align="center" style="display: inline-block;color:#1D1D1D;text-align:center;font-family:Arial;font-size:14px;">ПАНЕЛЬ УПРАВЛЕНИЯ РАЗРАБОТЧИКА</span><br>
<input class="field required" style="margin-top:10px;text-indent: 10px;" required="required" id="email" placeholder="Email" name="email" type="email"><br>
<input class="field required" style="margin-top:10px;text-indent: 10px;" required="required" id="password" placeholder="Пароль" name="passwd" type="password" value=""><br>
            @if ($errors !='[]')
                <div class="errors">
                        {{ $errors}}
                </div>
            @endif
<span style=""><label style="font-family: Arial;font-size:12px;display: inline-block;margin-top:7px;margin-bottom:7px;vertical-align:middle;"><input type="checkbox" name="option1" checked><span></span> Запомнить</label></span><br>
<span align="center" style="display: inline-block;height:19px;width:112px;background:#3DC76F;color:#FFFFFF;text-align:center;font-family: Arial;font-size:14px;padding-top:4px;margin-top:3px;margin-right:5px;" onclick="document.getElementById('form1').submit();">ВОЙТИ</span>
</form>

            </div>
        </div>
    </body>
</html>
