<!-- #include virtual="/_include/connect.inc" -->
<%   
   

    strSQL = "p_sz_test_updown_bet '" & request("member_no") & "','" & _
                                        request("updown_cd") & "','" & _
                                        request("bet_amt") & "'"

    'response.write strSQL
    'response.End

    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 

    set rsData = nothing
    set Dbcon = nothing
    
    Response.redirect "bettest.asp?member_id="&request("member_id")&"&member_no="&request("member_no")
 
%>
<!-- #include virtual="/_include/connect_close.inc" -->
