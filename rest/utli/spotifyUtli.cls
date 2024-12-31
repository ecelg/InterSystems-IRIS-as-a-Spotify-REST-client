Class rest.utli.spotifyUtli Extends %RegisteredObject
{

ClassMethod getSearchResult(str As %String = "") As %Status [ Language = objectscript ]
{
	//w ##class(rest.utli.spotifyUtli).getSearchResult()
	set rtn=0
	set a={}.%FromJSON(str) //from json tn dynamic object
	//w a,!
		
	// loop through the object using an iterator
	set iter = a.%GetIterator()
	while iter.%GetNext(.key , .value ) 
	{
		//write !, ?5, "Key: ", key, ", Value: ", value, " type: ", a.%GetTypeOf(key)_" with value "_a.%Get(key)
		if key="tracks"
		{
			//w !,?10,"call get tracks",!
			set std=##class(rest.utli.spotifyUtli).getTrakSearchResult(.value)
		}
		//set b=value
		//w !,?10,b.name
	}
	
	kill a
	return rtn
}

ClassMethod getTrakSearchResult(ByRef tracksobj As %DynamicObject) As %Status [ Language = objectscript ]
{
	//w ##class(rest.utli.spotifyUtli).getTrakSearchResult()
	set rtn=0
	
	// loop through the object using an iterator
	set iter = tracksobj.%GetIterator()
	while iter.%GetNext(.key , .value ) 
	{
		//write !, ?5, "Key: ", key, ", Value: ", value
		if key="items" 
		{
			// loop through the array using an iterator twice**
			set iter1=value.%GetIterator()
			while iter1.%GetNext(.key1 , .value1 )
			{
				kill tkobj
				set tkobj=##class(rest.spotify.track).%New()
				set rowid=""
				
				//write !, ?10, "Key: ", key1, ", Value: ", value1
				set iter2=value1.%GetIterator()
				while iter2.%GetNext(.key2 , .value2)
				{
					//write !, ?10, "Key: ", key2, ", Value: ", value2
					if key2="album" 
					{
						//set std=##class(rest.utli.spotifyUtli).getTrakSearchAlbumResult(.value2) //w !,?15,"call get album"
						set album=##class(rest.spotify.album).%New()
						set std=##class(rest.utli.spotifyUtli).getTrakSearchAlbumResult(.value2,.album)
						set tkobj.album=album
						kill album
					}
					if key2="external_urls" 
					{
						//w !,?15,value2.spotify
						set tkobj.spotifyurl=value2.spotify
					}
					if key2="name" 
					{
						//w !,?15,"name: ",value2
						set tkobj.name=value2
					}
					if key2="popularity" 
					{
						//w !,?15,"popularity: ",value2
						set tkobj.popularity=value2
					}
					if key2="track_number" 
					{
						//w !,?15,"track_number: ",value2
						set tkobj.tracknumber=value2
					}
					if key2="id" 
					{
						//w !,?15,"id: ",value2
						set tkobj.spotifyid=value2
						set rowid=##class(rest.spotify.track).checkRowid(value2)
					}
				}
				
				if (rowid=0)
				{
					set std=tkobj.%Save()
				}
				kill tkobj
			}
		}		
	}
	
	set rtn=1
	return rtn
}

ClassMethod getTrakSearchAlbumResult(ByRef albumobj As %DynamicObject, ByRef album As rest.spotify.album) As %Status [ Language = objectscript ]
{
	//w ##class(rest.utli.spotifyUtli).getTrakSearchAlbumResult()
	set rtn=0
	
	kill alobj
	set alobj=##class(rest.spotify.album).%New()
	set rowid=""
	
	// loop through the object using an iterator
	set iter = albumobj.%GetIterator()
	while iter.%GetNext(.key , .value ) 
	{
		//write !, ?5, "Key: ", key, ", Value: ", value
		if key="name" 
		{
			//w !,?10,"name: ",value
			set alobj.name=value
			
		}
		if key="release_date" 
		{
			//w !,?10,"release_date: ",value
			set alobj.releasedate=value
		}
		if key="id" 
		{
			//w !,?10,"id: ",value
			set alobj.spotifyid=value
			set rowid=##class(rest.spotify.album).checkRowid(value)
		}
		if key="artists" 
		{
			set artist=##class(rest.spotify.artists).%New()
			set std=##class(rest.utli.spotifyUtli).getTrakSearchArtistsResult(.value,.artist)
			set alobj.artists=artist
			kill artist
			//w !,?10,"call get artists"
		}
		if key="album_type" 
		{
			//w !,?10,"album_type: ",value
			set alobj.albumtype=value
			
		}
		if key="external_urls" 
		{
			//w !,?10,value.spotify
			set alobj.spotifyurl=value.spotify
		}
	}
	
	if (rowid=0)
	{
		set std=alobj.%Save()
		set album=alobj
	}
	if (rowid>0)
	{
		set album=##class(rest.spotify.album).%OpenId(rowid)
	}
	kill alobj
	
	set rtn=1
	return rtn
}

ClassMethod getTrakSearchArtistsResult(ByRef artistsobj As %DynamicObject, ByRef artist As rest.spotify.artists) As %Status [ Language = objectscript ]
{
	//w ##class(rest.utli.spotifyUtli).getTrakSearchArtistsResult()
	set rtn=0
	
	// loop through the array using an iterator twice**
	set iter = artistsobj.%GetIterator()
	while iter.%GetNext(.key , .value ) 
	{
		kill aobj
		set aobj=##class(rest.spotify.artists).%New()
		set rowid=""
		
		set iter1 = value.%GetIterator()
		while iter1.%GetNext(.key1 , .value1 ) 
		{
			//write !, ?5, "Key: ", key1, ", Value: ", value1
			
			if key1="id" 
			{
				set aobj.spotifyid=value1
				set rowid=##class(rest.spotify.artists).checkRowid(value1)
			}
			if key1="name" 
			{
				//w !,?12,"name: ",value1
				set aobj.name=value1
			}
			if key1="external_urls" 
			{
				//w !,?12,value1.spotify
				set aobj.spotifyurl=value1.spotify
			}
		}
		
		if (rowid=0)
		{
			set std=aobj.%Save()
			set artist=aobj
		}
		if (rowid>0)
		{
			set artist=##class(rest.spotify.artists).%OpenId(rowid)
		}
		
		kill aobj
	}
	
	set rtn=1
	return rtn
}

}
