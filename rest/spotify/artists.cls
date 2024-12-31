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

}
