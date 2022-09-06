<%
if request("stock_cd") = "" then
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

    strSQL = "p_sm_stock_insert '" & request("market_cd") & "','" & _
                                                request("stock_cd") & "','" & _
                                                request("company_name") & "''"

    response.Write strSQL
    response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "default.asp"

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
