Class rest.spotify.album Extends (%Persistent, %JSON.Adaptor)
{

Property name As %String;

Property albumtype As %String(%JSONFIELDNAME = "album_type");

Property releasedate As %String(%JSONFIELDNAME = "release_date");

Property spotifyid As %String(%JSONFIELDNAME = "id");

Property spotifyurl As %String(%JSONFIELDNAME = "spotify", MAXLEN = 100);

Property artists As artists;

ClassMethod checkRowid(spotifyid As %String = "") As %Integer [ Language = objectscript ]
{
	//w ##class(rest.spotify.album).checkRowid("6rUYFVeZl5rExNNV8seV98")
	set rtn=0
	set rowid=""
	&sql(select id into :rowid from rest_spotify.album where spotifyid=:spotifyid )
	//w rowid,!
	if rowid'="" set rtn=rowid
	return rtn
}

Storage Default
{
<Data name="albumDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>albumtype</Value>
</Value>
<Value name="4">
<Value>releasedate</Value>
</Value>
<Value name="5">
<Value>spotifyid</Value>
</Value>
<Value name="6">
<Value>spotifyurl</Value>
</Value>
<Value name="7">
<Value>artists</Value>
</Value>
</Data>
<DataLocation>^rest.spotify.albumD</DataLocation>
<DefaultData>albumDefaultData</DefaultData>
<IdLocation>^rest.spotify.albumD</IdLocation>
<IndexLocation>^rest.spotify.albumI</IndexLocation>
<StreamLocation>^rest.spotify.albumS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
