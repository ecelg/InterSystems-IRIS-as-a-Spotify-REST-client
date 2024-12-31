Class rest.spotify.artists Extends (%Persistent, %JSON.Adaptor)
{

Property name As %String;

Property spotifyid As %String(%JSONFIELDNAME = "id");

Property spotifyurl As %String(%JSONFIELDNAME = "spotify", MAXLEN = 100);

ClassMethod checkRowid(spotifyid As %String = "") As %Integer [ Language = objectscript ]
{
	//w ##class(rest.spotify.artists).checkRowid("6eUKZXaKkcviH0Ku9w2n3V")
	set rtn=0
	set rowid=""
	&sql(select id into :rowid from rest_spotify.artists where spotifyid=:spotifyid )
	//w rowid,!
	if rowid'="" set rtn=rowid
	return rtn
}

Storage Default
{
<Data name="artistsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>spotifyid</Value>
</Value>
<Value name="4">
<Value>spotifyurl</Value>
</Value>
</Data>
<DataLocation>^rest.spotify.artistsD</DataLocation>
<DefaultData>artistsDefaultData</DefaultData>
<IdLocation>^rest.spotify.artistsD</IdLocation>
<IndexLocation>^rest.spotify.artistsI</IndexLocation>
<StreamLocation>^rest.spotify.artistsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
