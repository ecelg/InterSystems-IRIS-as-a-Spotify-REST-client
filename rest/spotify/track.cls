Class rest.spotify.track Extends (%Persistent, %JSON.Adaptor)
{

Property name As %String;

Property popularity As %String;

Property tracknumber As %String(%JSONFIELDNAME = "track_number");

Property spotifyid As %String(%JSONFIELDNAME = "id");

Property spotifyurl As %String(%JSONFIELDNAME = "spotify", MAXLEN = 100);

Property album As album;

ClassMethod checkRowid(spotifyid As %String = "") As %Integer [ Language = objectscript ]
{
	//w ##class(rest.spotify.track).checkRowid("1cKuv7hAoX7ZN8f39hlDKX")
	set rtn=0
	set rowid=""
	&sql(select id into :rowid from rest_spotify.track where spotifyid=:spotifyid )
	//w rowid,!
	if rowid'="" set rtn=rowid
	return rtn
}

Storage Default
{
<Data name="trackDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>popularity</Value>
</Value>
<Value name="4">
<Value>tracknumber</Value>
</Value>
<Value name="5">
<Value>spotifyid</Value>
</Value>
<Value name="6">
<Value>spotifyurl</Value>
</Value>
<Value name="7">
<Value>album</Value>
</Value>
</Data>
<DataLocation>^rest.spotify.trackD</DataLocation>
<DefaultData>trackDefaultData</DefaultData>
<IdLocation>^rest.spotify.trackD</IdLocation>
<IndexLocation>^rest.spotify.trackI</IndexLocation>
<StreamLocation>^rest.spotify.trackS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
