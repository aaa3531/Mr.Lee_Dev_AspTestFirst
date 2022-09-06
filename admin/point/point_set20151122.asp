<%
if request("member_no") = "" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("회원을 선택하세요.");
    history.go(-1);
//-->
</SCRIPT>
<%
elseif request("point_amt") = "" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("No point");
    history.go(-1);
//-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sh_member_point_set '" & request("member_no") & "','" & _
                                         request("point_amt") & "','" & _
                                         Session("member_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "default.asp?member_no="&request("member_no")

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
