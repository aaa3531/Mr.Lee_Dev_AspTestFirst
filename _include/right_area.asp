<div style="margin:5px 0 0 0;clear:both;"></div>  

<div style="width:98%;margin:5px 0 5px 0;padding:5px;text-align:center;background-color:#e8e8e8;">
  <table width="100%" style="border-bottom:solid 0px #dddddd;">
      <tr height=22>
      <td colspan=3 align=center><span style="font-size:9pt;color:#0000ff;font-weight:bold;">지역사업 / 일자리</span>
      </td>
      <tr>
      <%
      strSQL = "p_gim_area_read"
      'response.Write strSQL
      'bRtn = Dbcon.GetResult(strSQL, rsArea)
      Set rsArea = Server.CreateObject("ADODB.RecordSet")
      rsArea.Open strSQL, DbCon, 1, 1    
  
      if NOT rsArea.EOF and NOT rsArea.BOF then

      Do While Not rsArea.EOF %>   
      <tr height=22>
      <td width="25%" align="center">
      <% if prov_old <> rsArea("province_desc") then %>
      <span style="font-size:9pt;"><%=rsArea("province_desc") %></span>
      <% end if %>
      </td>
      <td width="25%" align="center">
      <span style="font-size:9pt;font-weight:bold;"><%=rsArea("area_desc") %></span>
      </td>
      <td width="50%" align="center">100 / 100 / 1350
      </td>
      <tr>
      <%
        prov_old = rsArea("province_desc")
        rsArea.MoveNext
	    Loop 
	    
	    end if
        set rsArea = nothing
      %>
  </table>
</div>

