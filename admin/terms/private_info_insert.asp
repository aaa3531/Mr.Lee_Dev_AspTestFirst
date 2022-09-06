<%
if request("terms_desc") = "" then
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

    strSQL = "p_sm_private_info_insert '" & request("terms_desc") & "','" & _
                                                request("terms_version") & "','" & _
                                                request("start_date") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "private_info.asp"

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
