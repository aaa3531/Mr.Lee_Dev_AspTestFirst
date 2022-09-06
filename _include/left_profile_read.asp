
<!-- #include virtual="/_include/connect.inc" -->
<%   

    strSQL = "p_sm_member_point_read  '" & Session("member_no") & "'"

    'response.Write strSQL
    'response.end
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 
    
    data_desc = rsData("data_desc")   
    'data_rate = request("game_i") & "," & rsData("data_rate")    
          
    set rsData = nothing
    set Dbcon = nothing
    
    response.write data_desc
 
%>
<!-- #include virtual="/_include/connect_close.inc"-->