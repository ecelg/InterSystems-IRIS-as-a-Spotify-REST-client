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

}
