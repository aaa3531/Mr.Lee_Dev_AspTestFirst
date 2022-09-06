<%
if request("section_desc") = "" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("섹션이 비었습니다.");
    history.go(-1);
    //-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sm_terms_detail_insert '"     & request("terms_no") & "','" & _
                                                request("section_cd") & "','" & _
                                                request("section_desc") & "','" & _
                                                request("detail_cd") & "','" & _
                                                request("detail_desc") & "','" & _
                                                request("order_seq") & "'"
    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "terms_detail.asp?terms_no="&request("terms_no") & "&detail_no="&request("detail_no")

    end if
%>
<!-- #include virtual="/_include/connect_close.inc" -->
