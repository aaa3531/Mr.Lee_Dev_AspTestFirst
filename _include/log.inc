<%
  Set logDbCon = Server.CreateObject("ADODB.Connection")
  logDbCon.Open "dsn=smgmalldb;uid=smguser;pwd=smg1234;"

  strSQL = "p_sz_log '" & Request.SerVerVariables("REMOTE_ADDR") & "','" & _
                           Request.SerVerVariables("URL") & "','" & _
                           Session("member_no") & "','" & _
                           Request.SerVerVariables("HTTP_USER_AGENT") & "','" & _
                           now() & "','SMG'"                                                      
  'RESPONSE.write strSQL
  'response.end
 
  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, logDbCon, 1, 1

  set rs = nothing
  set logDbCon = nothing     
%>