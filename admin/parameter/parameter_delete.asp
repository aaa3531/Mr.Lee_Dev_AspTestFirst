<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sm_parameter_delete   '" & request("parameter_cd") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "default.asp"
  
%>
<!-- #include virtual="/_include/connect_close.inc" -->
