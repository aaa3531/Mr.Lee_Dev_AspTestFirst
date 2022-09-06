<!-- #include virtual="/_include/connect.inc" -->
<%   
   

    strSQL = "p_sz_test_theme_bet '" & request("game_no") & "','" & _
                                       request("bet_amt") & "'"

    'response.write strSQL
    'response.End

    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "bettest.asp"
 
%>
<!-- #include virtual="/_include/connect_close.inc" -->
