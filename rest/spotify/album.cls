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

}
