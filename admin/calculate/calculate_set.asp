<!-- #include virtual="/_include/connect.inc" -->
<%   
   
    if request("game_type")  = "U" then
      strSQL = "p_sh_calculate_updown '" & request("game_no") & "'"
    elseif request("game_type")  = "I" then
      strSQL = "p_sh_calculate_item '" & request("game_no") & "'"
    else 
      strSQL = "p_sh_calculate_theme '" & request("game_no") & "'"
    end if
    
    'response.write strSQL
    'response.End

    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "calculate_game.asp?game_no="&request("game_no")&"&game_type="&request("game_type")
 
%>
<!-- #include virtual="/_include/connect_close.inc" -->
