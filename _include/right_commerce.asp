<div style="width:96%;padding:5px;text-align:center;background-color:#ffffff;line-height:250%;"> 	

  <div style="font-family:맑은 고딕,Arial;font-size:12pt;color:#3388cc;font-weight:bold;">지역몰 현황</div>
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
  
  if NoDataSection = False then ' 데이터가 있으면 데이터 출력 %>
  <% Do While Not rsSection.EOF %>
  <div style="padding:0 3px 0 3px;margin:0px;font-family:맑은 고딕,Arial;font-size:9pt;color:#000000;text-align:left;border-bottom:dotted 1px #dddddd;">
    ●<%=rsSection("section_desc_short") %> (<%=rsSection("total_cnt") %>) : 운영<%=rsSection("operation_cnt") %>, 미지정<%=rsSection("ready_cnt") %></div>
  <%                                     
      	rsSection.MoveNext
	    Loop 
  
  else %>
    <div style="padding:0 3px 0 3px;margin:0px;font-family:맑은 고딕,Arial;font-size:9pt;color:#000000;text-align:left;">(브랜드 없음)</div>	
  <% end if     
        
     set rsSection = nothing
  %> 
	
</div>

