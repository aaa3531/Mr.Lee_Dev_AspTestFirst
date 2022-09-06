<!-- #include virtual="/_include/connect.inc" -->
<% 
recommend_id = Request.Form("mrecommend") 
if recommend_id="" then 
%>
<script>alert("추천인 아이디를 입력하여 주시기 바랍니다.");</script>
<% 
response.end 
end if 

strSQL = "p_sm_member_recommendcheck  '" & recommend_id & "'" 
Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1 


Cnt = 0 
If not rsData.EOF Then 
Cnt = rsData("id_cnt") 
End If 
rsData.Close 
Set rsData = nothing 
if cCur(Cnt) >= 0 then 
%>
<script language="javascript">
    opener.location.href = "/sumember/register_step3.asp?recommend_id=<%=recommend_id%>";
    self.close();
 </script> 

<% 
response.end 
else 
%>
<script>$("#recommendchkspan").text("추천인 아이디가 아닙니다.");</script>
<% 
response.end 
end if 
%> 
<!-- #include virtual="/_include/connect_close.inc" -->