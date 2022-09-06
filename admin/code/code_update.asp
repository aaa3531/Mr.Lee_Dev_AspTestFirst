<%
if Session("member_no") = "" then 
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("Login ...");
    history.go(-1);
//-->
</SCRIPT>
<%
else
%>
<!-- #include virtual="/_include/connect.inc" -->
<%

  strSQL = "p_sm_code_update '" & request("code_no") & "','" & _
                                  request("code_cd") & "','" & _
                                  request("code_desc") & "','" & _
                                  request("order_seq") & "'"

  'response.write strSQL
  'response.end

  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1 

  set rs = nothing
  set DbCon = nothing  
  
  Response.Redirect "default.asp?codetype_cd="&request("codetype_cd")&"&code_no="&request("code_no")

%>
<!-- #include virtual="/_include/connect_close.inc" -->
<%
end if
%>
