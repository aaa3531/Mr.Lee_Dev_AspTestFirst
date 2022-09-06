<%
if request("theme_no") < "1" or request("stock_no") = "" then
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

    strSQL = "p_sh_theme_stock_set '" & request("theme_no") & "','" & _
                                     request("stock_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "kospitheme.asp?page="&request("page") & "&theme_no="&request("theme_no")

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
