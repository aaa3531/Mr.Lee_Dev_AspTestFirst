<%
if request("grade_cd") = "" then
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

    strSQL = "p_sm_grade_insert '" & request("grade_cd") & "','" & _
                                     request("parent_cd") & "','" & _
                                     request("grade_desc") & "','" & _
                                     request("margin_rate") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "grade.asp?page="&request("page") & "&grade_no="&request("grade_no")

end if     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
