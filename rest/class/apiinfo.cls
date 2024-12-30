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

}
