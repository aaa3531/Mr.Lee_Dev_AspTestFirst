<!-- #include virtual="/_include/login_check.inc" -->
<%
if request("charge_amt") = "" then
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

    strSQL = "p_sh_member_point_set '" & request("charge_no") & "','" & _
                                         request("member_no") & "','" & _
                                         request("charge_amt") & "','" & _
                                         Session("member_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    'session("memo_cnt") = rsData("memo_cnt")

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "default.asp"

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
