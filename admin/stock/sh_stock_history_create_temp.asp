<%
if Session("member_no") = ""  then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("Register or Login please...");
    history.go(-1);
//-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_stock_history_create_temp '" & request("market_cd") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 
          
    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "stock_view.asp?market_cd="& request("market_cd")

end if     
%>
<!-- #include virtual="/_include/connect_close.inc"-->
