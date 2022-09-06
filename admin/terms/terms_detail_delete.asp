<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sm_terms_detail_delete  '" & request("detail_no") & "'"

    'response.Write request("terms_no")
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "terms_detail.asp?terms_no="&request("terms_no")
  
%>
<!-- #include virtual="/_include/connect_close.inc" -->
