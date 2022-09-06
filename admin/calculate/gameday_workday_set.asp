<!-- #include virtual="/_include/connect.inc" -->
<%   
   

    strSQL = "p_sm_gameday_workday_set '" & request("yyyymmdd") & "'"
      
    'response.write strSQL
    'response.End

    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "gameday.asp?yyyymm="&request("yyyymm")
 
%>
<!-- #include virtual="/_include/connect_close.inc" -->
