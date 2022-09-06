<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sm_grade_delete    '" & request("grade_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "grade.asp?page="&request("page") 

%>
<!-- #include virtual="/_include/connect_close.inc" -->
