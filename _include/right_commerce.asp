<div style="width:96%;padding:5px;text-align:center;background-color:#ffffff;line-height:250%;"> 	

  <div style="font-family:���� ���,Arial;font-size:12pt;color:#3388cc;font-weight:bold;">������ ��Ȳ</div>
  <%
  strSQL = "p_fmm_section_read "
  'response.Write strSQL
  Set rsSection = Server.CreateObject("ADODB.RecordSet")
  rsSection.Open strSQL, cDbCon, 1, 1

  if rsSection.EOF or rsSection.BOF then
	NoDataSection = True
  Else
	NoDataSection = False
  end if 
  
  if NoDataSection = False then ' �����Ͱ� ������ ������ ��� %>
  <% Do While Not rsSection.EOF %>
  <div style="padding:0 3px 0 3px;margin:0px;font-family:���� ���,Arial;font-size:9pt;color:#000000;text-align:left;border-bottom:dotted 1px #dddddd;">
    ��<%=rsSection("section_desc_short") %> (<%=rsSection("total_cnt") %>) : �<%=rsSection("operation_cnt") %>, ������<%=rsSection("ready_cnt") %></div>
  <%                                     
      	rsSection.MoveNext
	    Loop 
  
  else %>
    <div style="padding:0 3px 0 3px;margin:0px;font-family:���� ���,Arial;font-size:9pt;color:#000000;text-align:left;">(�귣�� ����)</div>	
  <% end if     
        
     set rsSection = nothing
  %> 
	
</div>

