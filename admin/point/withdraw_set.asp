<%
if request("withdraw_amt") = "" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("금액을 입력하세요.");
    history.go(-1);
//-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_member_withdraw_set '" & request("withdraw_no") & "','" & _
                                            request("member_no") & "','" & _
                                            request("withdraw_amt") & "','" & _
                                            Session("member_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    
    
    Response.redirect "withdraw.asp"

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
