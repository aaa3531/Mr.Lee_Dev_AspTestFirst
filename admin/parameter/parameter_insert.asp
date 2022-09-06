<%
if request("parameter_cd") = "" then
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

    strSQL = "p_sm_parameter_insert '" &        request("parameter_cd") & "','" & _
                                                request("parameter_desc") & "','" & _
                                                request("parameter_value") & "','" & _
                                                request("default_value") & "','" & _
                                                request("parameter_type") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "default.asp"

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
