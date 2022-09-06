<% Response.CharSet = "UTF-8" %>
<!-- #include virtual="/_include/connect.inc" -->
<% 

if Session("member_no") = "" then
response.redirect "/"
end if

strSQL = "p_sm_session_check '" &  Session("member_no") & "','" & _
                                   Request.SerVerVariables("REMOTE_ADDR")  & "'"
    
    'response.Write strSQL
    'response.End
    
    'bRtn = dbcon.GetResult(strSQL, rsData)    
    Set rsData=Server.CreateObject("ADODB.Recordset")
    rsData.Open strSQL, DBCon, 1, 1 
    
      result_desc = rsData("result_desc")
      count = rsData("count")

	  'response.write result_desc & count

    set rsData = nothing

	if count > "0" then 
      
	  Session.Abandon 	
      response.redirect "/default.asp?result_desc="&result_desc
	end if
%>
<!-- #include virtual="/_include/connect_close.inc" -->