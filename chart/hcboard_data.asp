

<%
  Set Dbcon = Server.CreateObject("ADODB.Connection")
  DbCon.Open "dsn=healthcaredb;uid=careuser;pwd=care1234;"
  'strSQL = "p_hch_hcinfo_calendar_chart2 '" & Session("yyyymm") & "','" & Session("member_no") & "'"
  strSQL = "p_hch_hcinfo_calendar_chart2 '" & Session("yyyymm") & "','3'"
  
  'response.Write strSQL
  'response.end

  Set rsCalendar = Server.CreateObject("ADODB.RecordSet")
  rsCalendar.Open strSQL, DbCon, 1, 1
  
  if rsCalendar.EOF or rsCalendar.BOF then
    NoDataCalendar = True
  Else
    NoDataCalendar = False
    contents1 = rsCalendar("contents1")
  end if  
    
  set rsCalendar = nothing
  set DBCon = nothing

  response.Write contents1

%>
