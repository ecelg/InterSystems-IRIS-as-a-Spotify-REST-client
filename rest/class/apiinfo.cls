Class rest.class.apiinfo Extends (%Persistent, %JSON.Adaptor)
{

Property apiname As %String;

Property clientid As %String(%JSONFIELDNAME = "client_id");

Property clientsecret As %String(%JSONFIELDNAME = "client_secret");

Property granttype As %String(%JSONFIELDNAME = "grant_type");

Property tokentype As %String(%JSONFIELDNAME = "token_type");

Property accesstoken As %String(%JSONFIELDNAME = "access_token", MAXLEN = 200);

Property expiresin As %String(%JSONFIELDNAME = "expires_in");

Property refreshtoken As %String(%JSONFIELDNAME = "refresh_token", MAXLEN = 200);

Property authurl As %String(MAXLEN = 100);

Property authheader As %String(MAXLEN = 100);

Property apiurl As %String(MAXLEN = 100);

Property refreshbefore As %String;

Property updateat As %String;

ClassMethod checkRowid(apiname As %String = "") As %Integer [ Language = objectscript ]
{
    //w ##class(rest.class.apiinfo).checkRowid("Spotify")
    set rtn=0
    set rowid=""
    &sql(select id into :rowid from rest_class.apiinfo where apiname=:apiname )
    //w rowid,!
    if rowid'="" set rtn=rowid
    return rtn
}

Storage Default
{
<Data name="apiinfoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>apiname</Value>
</Value>
<Value name="3">
<Value>clientid</Value>
</Value>
<Value name="4">
<Value>clientsecret</Value>
</Value>
<Value name="5">
<Value>granttype</Value>
</Value>
<Value name="6">
<Value>tokentype</Value>
</Value>
<Value name="7">
<Value>accesstoken</Value>
</Value>
<Value name="8">
<Value>expiresin</Value>
</Value>
<Value name="9">
<Value>refreshtoken</Value>
</Value>
<Value name="10">
<Value>authurl</Value>
</Value>
<Value name="11">
<Value>authheader</Value>
</Value>
<Value name="12">
<Value>apiurl</Value>
</Value>
<Value name="13">
<Value>refreshbefore</Value>
</Value>
<Value name="14">
<Value>updateat</Value>
</Value>
</Data>
<DataLocation>^rest.class.apiinfoD</DataLocation>
<DefaultData>apiinfoDefaultData</DefaultData>
<ExtentSize>1</ExtentSize>
<IdLocation>^rest.class.apiinfoD</IdLocation>
<IndexLocation>^rest.class.apiinfoI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="accesstoken">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="apiname">
<AverageFieldSize>9</AverageFieldSize>
<OutlierSelectivity>.999999:"Spotify"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="apiurl">
<AverageFieldSize>28</AverageFieldSize>
<OutlierSelectivity>.999999:"https://api.spotify.com/v1"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="authheader">
<AverageFieldSize>29</AverageFieldSize>
<OutlierSelectivity>.999999:"type: application/x-www-for"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="authurl">
<AverageFieldSize>40</AverageFieldSize>
<OutlierSelectivity>.999999:"https://accounts.spotify.com/api/token"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="clientid">
<AverageFieldSize>34</AverageFieldSize>
<OutlierSelectivity>.999999:"b43bf1363dcf47b7a627aa10c4f2b3f4"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="clientsecret">
<AverageFieldSize>34</AverageFieldSize>
<OutlierSelectivity>.999999:"45ffde559694487aa750acbd40ee54e7"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="expiresin">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="granttype">
<AverageFieldSize>20</AverageFieldSize>
<OutlierSelectivity>.999999:"client_credentials"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="refreshbefore">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="refreshtoken">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="tokentype">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="updateat">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^rest.class.apiinfoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
