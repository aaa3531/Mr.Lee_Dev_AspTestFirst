<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sm_private_policy_delete     '" & request("terms_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "private_policy.asp?page="&request("page") & "&terms_no="&request("terms_no")
  
%>
<!-- #include virtual="/_include/connect_close.inc" -->
