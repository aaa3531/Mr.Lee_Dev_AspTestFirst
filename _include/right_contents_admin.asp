<SCRIPT language="javascript">
    function yyyymmselect() {
        formCalendar.submit();
    }
</SCRIPT>
<%
   Set Dbcon = Server.CreateObject("eDBConn.CQuery")

  ' 월 읽기
  if request("yyyymm") = "" then

    strSQL = "SELECT  SUBSTRING(CONVERT(VARCHAR(8),getdate(),112),1,6) as yyyymm"
    bRtn = dbcon.GetResult(strSQL, rsData)    
    yyyymm = rsData("yyyymm")
    set rsData = nothing

  else
  
    if request("date_arrow") = "1" then    ' 후월
      strSQL = "select substring(CONVERT(varchar(8),dateadd(month,1,convert(datetime,'"& request("yyyymm") &"01',112)),112),1,6) as yyyymm"
      bRtn = dbcon.GetResult(strSQL, rsData)    
      yyyymm = rsData("yyyymm")
      set rsData = nothing
    elseif request("date_arrow") = "0" then    ' 전월
      strSQL = "select substring(CONVERT(varchar(8),dateadd(month,-1,convert(datetime,'"& request("yyyymm") &"01',112)),112),1,6) as yyyymm"
      bRtn = dbcon.GetResult(strSQL, rsData)    
      yyyymm = rsData("yyyymm")
      set rsData = nothing
    else 
      yyyymm = request("yyyymm")
    end if
  
  end if
  
 %>
<!-- #include virtual="/_include/right_sub_link.asp" -->
<div id="righttitle">ADMIN STATUS</div>  
<div class="rightbox">
<div class="title">daily log</div>
<span class="contents">
	    <form action="default.asp" id="formCalendar" name="formCalendar" method="post">
        <a href="default.asp?project_no=<%=project_no%>&yyyymm=<%=yyyymm%>&date_arrow=0"><img src="/images/btn_arrow_qleft.jpg" height="15" width="15" border=0></a>
		<input type="text" name="yyyymm" size="6" style="width:60" class="input" ID="Text3" value="<%=yyyymm%>">
        <a href="default.asp?project_no=<%=project_no%>&yyyymm=<%=yyyymm%>&date_arrow=1"><img src="/images/btn_arrow_qright.jpg" height="15" width="15" border=0></a>
		&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;        				
        <img src="/images/btn_arrow_select.jpg" height="15" width="15" border="0" onclick="yyyymmselect();" >&nbsp;
        </form>	
</span>
<div class="line"></div>
   <%
    strSQL = " p_gih_log_summary '" & yyyymm & "'"
             
    bRtn = dbcon.GetResult(strSQL, rsLog)
 
    if rsLog.EOF or rsLog.BOF then
    	NoDataLog = True
    Else
    	NoDataLog = False
    end if   

    if NoDataLog = False then
    
    Do While Not rsLog.EOF
    %>
    <div class="column"><a href="/giadmin/loglist.asp?log_date=<%=rsLog("log_date") %>"><%=rsLog("log_date") %></a></div>
    <div class="column"><a href="/giadmin/loglist.asp?log_date=<%=rsLog("log_date") %>"><%=rsLog("count") %></a></div>
    <div class="column"><%=rsLog("session_count") %></div>
    <%                                     
     	rsLog.MoveNext
	    Loop 
      	set rsLog = nothing
    else %>
    <% end if %>
</div>