<html>
<title>
</title>
<body>

test


<%
  Set Dbcon = Server.CreateObject("ADODB.Connection")
  DbCon.Open "dsn=hhsdatadb;uid=hhsdata;pwd=epdlxj7788!;"


  strSQL = "p_sh_index_ladder_set 'KOSPI','20160719:18:39',1.2345,1.2345,1.2345,1.2345,0 "
 
  response.write strSQL 
  'response.end

  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1 

  Set rs = nothing
  Set Dbcon = nothing
%>

</body>
