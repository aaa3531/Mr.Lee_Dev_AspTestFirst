<% 
if Session("member_no") < "1" then
response.redirect "/"
else
 strSQL = "p_sm_member_check '" & session("member_no") & "'"
  'response.write strSQL
  'response.End
  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if NOT rsData.EOF and NOT rsData.BOF then
    session("point_total") = rsData("point_total")
    session("memo_cnt") = rsData("memo_cnt")
  end if  
end if
%>