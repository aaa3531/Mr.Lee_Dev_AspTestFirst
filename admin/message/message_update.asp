<%
if request("message_desc") = "" then
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

    strSQL = "p_sm_message_admin_update '"    & request("message_no") & "','" & _
                                                request("message_desc") & "','" & _
                                                request("order_seq") & "','" & _
                                                request("status_flag") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "default.asp?page="&request("page") & "&message_no="&request("message_no")

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
