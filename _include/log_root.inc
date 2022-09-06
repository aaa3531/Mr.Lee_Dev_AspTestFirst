<%
  Set logDbCon = Server.CreateObject("ADODB.Connection")
  logDbCon.Open "PROVIDER=SQLOLEDB;DATA SOURCE=sql16-004.cafe24.com;UID=qqq3531;PWD=ehqkr01@;DATABASE=qqq3531"

  strSQL = "p_sz_log '" & Request.SerVerVariables("REMOTE_ADDR") & "','" & _
                           Request.SerVerVariables("URL") & "','" & _
                           Session("member_no") & "','" & _
                           Session("member_id") & "','" & _
                           Request.SerVerVariables("HTTP_USER_AGENT") & "','" & _
                           now() & "','SMG'"                                                      
  'RESPONSE.write strSQL
  'response.end
 
  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, logDbCon, 1, 1

  set rs = nothing

  strSQL = "p_sz_ip_count '" & Request.SerVerVariables("REMOTE_ADDR") & "'"     

  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, logDbCon, 1, 1

  Session("ip_count") = rs("ip_count")

  'RESPONSE.write Session("ip_count")
  'response.end
  
  set rs = nothing
  set logDbCon = nothing     
%>