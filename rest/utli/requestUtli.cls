Class rest.utli.requestUtli Extends %RegisteredObject
{

ClassMethod checkoutToken(apiname = "", withgrandtype = 1) As %String [ Language = python ]
{
	#w ##class(rest.utli.requestUtli).checkoutToken("Spotify")
	import requests
	import json
	import iris
	
	# get the apiinfo object by apiname
	rowid=iris.cls('rest.class.apiinfo').checkRowid(apiname)
	a=iris.cls('rest.class.apiinfo')._OpenId(rowid)
	
	# parameter perparation
	api_baseurl=a.authurl
	params=""
	if withgrandtype==1:
		#print ('grandtype ='+a.granttype)
		params="grant_type="+a.granttype+"&client_id="+a.clientid+"&client_secret="+a.clientsecret
	else:
		#print ('without grandtype')
		params="client_id="+a.clientid+"&client_secret="+a.clientsecret
	contenttype=a.authheader
	headers={"Content-Type":contenttype}
	api_url=api_baseurl+"?"+params
	#print(api_url)
	del a
	
	# post it
	response = requests.post(api_url,headers=headers, verify=False)
	#print(response)
	if response.status_code==200:
		return json.dumps(response.json())
	else:
		return response.status_code
}

ClassMethod getToken(apiname As %String = "") As %String [ Language = objectscript ]
{
	//w ##class(rest.utli.requestUtli).getToken("Spotify")
	
	set token="0"
	set rowid=##class(rest.class.apiinfo).checkRowid(apiname)
	if (rowid'=0)
	{
		kill a
		set a=##class(rest.class.apiinfo).%OpenId(rowid)
		set token=a.accesstoken
		
		// check expirey
		set tokenexpired=0
		set refreashbefore=a.refreshbefore
		if (token="")||(refreashbefore="")
		{
			set tokenexpired=1
		}else
		{
			set rfdate=+$p(refreashbefore,",",1)
			set rftime=+$p(refreashbefore,",",2)
			if (rftime<+$p($h,",",2)) 
			{
				if (rfdate<=+$p($h,",",1)) set tokenexpired=1
			}else
			{
				if (rfdate<+$p($h,",",1)) set tokenexpired=1
			}			
			 
		}
		
		// checkout token
		if (token="")||(tokenexpired=1)
		{
			set b={}.%FromJSON(##class(rest.utli.requestUtli).checkoutToken("Spotify"))
			//w b."access_token",",",b."token_type",",",b."expires_in",!
			
			//set the update before
			set rbdate=$p($h,",",1)
			set rbtime=+$p($h,",",2)+b."expires_in"
			if (rbtime>86400)
			{
				set rbdate=+rbdate+1
				set rbtime=+rbtime-86400
			}
			//w rbdate_","_rbtime,!
			
			set a.accesstoken=b."access_token"
			set a.tokentype=b."token_type"
			set a.expiresin=b."expires_in"
			set a.refreshbefore=rbdate_","_rbtime
			set a.updateat=$h
			set std=a.%Save()
			
			return a.accesstoken
		}
	}
	return token
}

ClassMethod getdata(apiname = "", path = "", query = "0") As %String [ Language = python ]
{
	#w ##class(rest.utli.requestUtli).getdata("Spotify","/artists/4Z8W4fKeB5YxbusRsdQVPb")
	#w ##class(rest.utli.requestUtli).getdata("Spotify","/search","offset=2&limit=2&query=Ed%20Sheeran&type=artist&market=SG")
	#w ##class(rest.utli.requestUtli).getdata("Spotify","/tracks/5cy3CNTBZbX8vZUIsu4p7K","market=SG")
	#w ##class(rest.utli.requestUtli).getdata("Spotify","/search","offset=5&limit=10&query=Shape%20of%20you&type=track&market=SG")
	import requests
	import json
	import iris
	
	# get the token by apiname
	token=iris.cls('rest.utli.requestUtli').getToken(apiname)
	
	# get the apiinfo object by apiname
	rowid=iris.cls('rest.class.apiinfo').checkRowid(apiname)
	a=iris.cls('rest.class.apiinfo')._OpenId(rowid)
	
	# parameter perparation
	api_baseurl=a.apiurl
	api_url=api_baseurl+path
	if query!="0":
		api_url=api_baseurl+path+"?"+query
	
	atoken=a.tokentype+" "+token
	headers={"Authorization":atoken}
	
	del a
	
	# get it
	response = requests.get(api_url,headers=headers, verify=False)
	return json.dumps(response.json())
}

}
