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

}
