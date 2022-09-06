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


  section_desc = request("section_desc")
  section_desc = Replace(section_desc, "'", "''")
  section_desc = Replace(section_desc, "`", "''")
  section_desc = Replace(section_desc, chr(13), "<BR>")
  section_desc = Replace(section_desc, "display:none", "")

  detail_desc = request("detail_desc")
  detail_desc = Replace(detail_desc, "'", "''")
  detail_desc = Replace(detail_desc, "`", "''")
  detail_desc = Replace(detail_desc, chr(13), "<BR>")
  detail_desc = Replace(detail_desc, "display:none", "")

    strSQL = "p_sm_private_info_detail_insert '"     & request("terms_no") & "','" & _
                                                request("section_cd") & "','" & _
                                                section_desc & "','" & _
                                                request("detail_cd") & "','" & _
                                                detail_desc & "','" & _
                                                request("order_seq") & "'"
    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "private_info_detail.asp?terms_no="&request("terms_no") & "&detail_no="&request("detail_no")

    end if
%>
<!-- #include virtual="/_include/connect_close.inc" -->
