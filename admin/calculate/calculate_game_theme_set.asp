<!-- #include virtual="/_include/connect.inc" -->
<%   
   

    strSQL = "p_sh_calculate_theme '" & request("game_no") & "'"
      
    'response.write strSQL
    'response.End

    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "calculate_game_theme.asp?yyyymmdd="&request("yyyymmdd")&"&game_no="&request("game_no")
 
%>
<!-- #include virtual="/_include/connect_close.inc" -->
