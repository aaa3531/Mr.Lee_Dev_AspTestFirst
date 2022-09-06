<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sm_game_updown_kospi_time '" & request("game_day") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "updown_time.asp?yyyymmdd="&request("game_day")
    
%>
<!-- #include virtual="/_include/connect_close.inc" -->
