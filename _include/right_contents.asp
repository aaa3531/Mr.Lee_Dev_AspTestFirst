
<style>
#righttech img {
  transition: all 1s linear;
  -webkit-transition: all 1s linear;  
  -moz-transition: all 1s ease;
  -o-transition: all 1s ease;
  -ms-transition: all 1s ease;
}
#righttech:hover img {
  transform:rotate(180deg);
  -webkit-transform:rotate(180deg);   
  -moz-transform:rotate(180deg);
  -o-transform:rotate(180deg);
  -ms-transform:rotate(180deg);
}
</style>    


<div style="height:5px;margin:5px 0 0 0;clear:both;"></div>  

<div style="width:98%;margin:5px 0 5px 0;padding:5px;text-align:center;background-color:#ffffff;">
Weekly log ( <span style="color:#0000ff;font-weight:bold;">App</span> / <span style="color:#d71874;font-weight:bold;">Click</span> )
  <table width="100%" style="border-bottom:solid 0px #dddddd;">
  <tr>
      <%
      strSQL = "p_gih_log_home_read"
      'response.Write strSQL
      bRtn = giDbcon.GetResult(strSQL, rsLog)

      if NOT rsLog.EOF and NOT rsLog.BOF then

      Do While Not rsLog.EOF %>   
      <td width="14%" align="center" valign="bottom">
      <% 
      y1 = (rsLog("app_cnt") * (rsLog("cnt_max") / rsLog("app_max")) / rsLog("cnt_max")) * 60 
      y2 = (rsLog("session_count") / rsLog("cnt_max")) * 60 
      %>
      <img src="/images/icon_bluebar.png" style="width:10px;height:<%=y1 %>;" />
      <img src="/images/icon_redbar.png" style="width:10px;height:<%=y2 %>;" /><br>
      <span style="font-size:4pt;"><%=rsLog("app_cnt") %><br /><%=rsLog("session_count") %><br />
      <%=mid(rsLog("log_date"),7,2) %>¿œ
      </span>
      </td>
      <%
        rsLog.MoveNext
	    Loop 
	    
	    end if
        set rsLog = nothing
      %>
  </tr>
  </table>
</div>

