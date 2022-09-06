<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_calculate_item_close '" & request("yyyymmdd") & "'"
    
    'response.write strSQL
    'response.End

    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "calculate.asp?yyyymmdd="&request("yyyymmdd")
 
%>
<!-- #include virtual="/_include/connect_close.inc" -->
