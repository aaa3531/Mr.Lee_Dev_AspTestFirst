<%
if request("margin_rate") = "" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("�׸��� ������ϴ�.");
    history.go(-1);
//-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sm_member_admin_update '" & request("member_no") & "','" & _
                                            request("margin_rate") & "','" & _
                                                request("b2b_flag") & "','" & _
                                                request("admin_flag") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "default.asp?page="&request("page") & "&member_no="&request("member_no")

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
