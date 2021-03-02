<html>
<meta charset="utf-8">
<link rel="stylesheet" href="{{ asset('css/stylesheet.css') }}" />
<script type="text/javascript" src="{{ URL::asset('js/jquery.js') }}"></script>
<body>
Hello World ! {{ $urls[0]->body }}


{!! Form::open(['action' => 'PhotoController@index']) !!}
{{ Form::text('email', null,array('class' => 'field required', 'id' => 'email',
    'placeholder' => 'Email')) }}
{{ Form::password('passwd', array('class' => 'field required', 'id' => 'password',
    'placeholder' => 'Пароль')) }}
{{Form::textarea('keterangan', null, ['class'=>'form-control']) }}
<button type="submit" class="btn btn-primary">Submit</button>
{!! Form::close() !!}
</body>
</html>