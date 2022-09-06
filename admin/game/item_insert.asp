<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sm_game_item_insert '"& request("yyyymmdd") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "item.asp?page="&request("page")&"&yyyymmdd="&request("yyyymmdd")
 
%>
<!-- #include virtual="/_include/connect_close.inc" -->
