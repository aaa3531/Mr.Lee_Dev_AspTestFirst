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
<!-- #include virtual="/_include/connect2.inc" -->
<%   

    strSQL = "p_sm_stock_admin_update '" & request("stock_no") & "','KOSDAQ','" & _
                                                request("stock_cd") & "','" & _
                                                request("company_name") & "','" & _
                                                request("stock_name") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "default.asp?page="&request("page") & "&stock_no="&request("stock_no")

end if     
%>
<!-- #include virtual="/_include/connect_close2.inc" -->
