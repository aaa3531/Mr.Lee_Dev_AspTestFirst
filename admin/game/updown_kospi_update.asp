<!-- #include virtual="/_include/connect.inc" -->
<%   

        strSQL = "p_sm_game_updown_update '" & request("game_no") & "','" & _
                                               request("status_flag") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "updown_kospi.asp?page="&request("page")&"&game_no="&request("game_no")
    
%>
<!-- #include virtual="/_include/connect_close.inc" -->
