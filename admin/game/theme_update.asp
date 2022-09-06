<%
if request("theme_name") = "" then
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

    strSQL = "p_sm_theme_update '" & request("theme_no") & "','KOSDAQ','" & _   
                                     request("theme_name") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "theme.asp?theme_no="&request("theme_no")

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
