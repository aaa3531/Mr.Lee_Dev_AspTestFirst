<!-- #include virtual="/_include/login_check.inc" -->
<%
if request("menu_name") = "" or request("cat_desc") = "" then
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

    strSQL = "p_sm_bottom_menu_set '" & request("flag") & "','" & _
                                                request("menu_no") & "','" & _
                                                request("cat_desc") & "','" & _
                                                request("menu_name") & "','" & _
                                                request("menu_desc") & "','" & _
                                                request("source_link") & "','" & _
                                                request("order_seq") & "'"

    'response.Write strSQL
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1
    
    set rsData = nothing
%>
<!-- #include virtual="/_include/connect_close.inc" -->
<%        
    if request("flag") = "2" then
    Response.redirect "default.asp?menu_no="&Request("menu_no")
    else
    Response.redirect "default.asp"
    end if
    
end if     
%>
