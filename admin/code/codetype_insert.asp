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

  strSQL = "p_sm_codetype_insert '" & request("codetype_cd") & "','" & _
                                        request("codetype_desc") & "'"

  'response.write strSQL
  'response.end

  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1 

  set rs = nothing
  set DbCon = nothing  
  
  Response.Redirect "default.asp"

%>
<!-- #include virtual="/_include/connect_close.inc" -->
<%
end if
%>
