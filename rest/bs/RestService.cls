Class rest.bs.RestService Extends %CSP.REST
{

Parameter CONTENTTYPE = "application/json";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
		<Route Url="/hello" Method="GET" Call="HelloWorld" />
        <Route Url="/spotify/track/:id" Method="GET" Call="Track" />
        <Route Url="/spotify/searchtrack" Method="GET" Call="SearchTrack" />
	</Routes>
}

ClassMethod HelloWorld() As %Status
{
	//define a DynamicObject
	#dim tJSON As %DynamicObject={}
	
	//set the keys and values
	set tJSON."test_message"="Hello World!!"
	
	// write to response
	do ##class(%JSON.Formatter).%New().Format(tJSON)
	
	return $$$OK
}

ClassMethod Track(pId As %Integer) As %Status
{
	kill a
	//open an object with id
	set a=##class(rest.spotify.track).%OpenId(pId)
	
	//convert to JSON String
	set b=""
	do a.%JSONExportToString(.b)
	kill a
	
	// write to response
	w b
	return $$$OK
}

ClassMethod SearchTrack() As %Status
{
	// get the parameter "name"
	#dim tname As %String=$GET(%request.Data("name",1),"")
	// get the parameter "name"
	#dim tmarket As %String=$GET(%request.Data("market",1),"")
	// get the parameter "name"
	#dim tartists As %String=$GET(%request.Data("artists",1),"")
	
	set sname="%"_tname_"%"
	set trowid=0
	&sql(SELECT top 1 ID into :trowid FROM rest_spotify.track where name like :sname order by popularity desc)
	set tarowid=""
	if (tartists'="")
	{
		set sartists=tartists
		&sql(SELECT top 1 ID into :trowid FROM rest_spotify.track where name like :sname  and album->artists->name like :sartists order by popularity )
	}
	if tarowid'="" set trowid=tarowid
	/*//debug
	//define a DynamicObject
	#dim tJSON As %DynamicObject={}
	//set the keys and values
	set tJSON."debug_message_name"=$replace(tname," ","%20")
	set tJSON."debug_message_market"=tmarket
	set tJSON."debug_message_rowid"=trowid
	// write to response
	do ##class(%JSON.Formatter).%New().Format(tJSON)
	*/
	
	if (trowid="")
	{
		/*//debug
		//define a DynamicObject
		#dim tJSON As %DynamicObject={}
		//set the keys and values
		set tJSON."debug_message_rowid"="not found"
		// write to response
		do ##class(%JSON.Formatter).%New().Format(tJSON)
		*/
		
		set tquery="offset=5&limit=10&query="_tname_"&type=track&market="_tmarket
		set str=##class(rest.utli.requestUtli).getdata("Spotify","/search",tquery)
		set std=##class(rest.utli.spotifyUtli).getSearchResult(str)
		&sql(SELECT top 1 ID into :trowid FROM rest_spotify.track where name like :sname order by popularity desc)
	}
	if (trowid>0)
	{
		//open an object with id
		set a=##class(rest.spotify.track).%OpenId(trowid)
		
		//convert to JSON String
		set b=""
		do a.%JSONExportToString(.b)
	
		// write to response
		w b
		return $$$OK
	}
	
	return $$$OK
}

}
