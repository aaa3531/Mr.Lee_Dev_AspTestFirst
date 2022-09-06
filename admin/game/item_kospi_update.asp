<%
if request("game_no") = "" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("항목이 비었습니다.");
    history.go(-1);
//-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sm_game_item_update '" & request("game_no") & "','" & _
                                         request("status_flag") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "item_kospi.asp?page="&request("page")&"&game_no="&request("game_no")

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
