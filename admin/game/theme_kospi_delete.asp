
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sm_theme_delete  '" & request("theme_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "kospitheme.asp?page="&request("page")&"&theme_no="&request("theme_no")
  
%>
<!-- #include virtual="/_include/connect_close.inc" -->
