<div style="width:98%;padding:5px;text-align:center;background-color:#ebf1de;"> 	
        <%
          strSQL = "p_irfh_main_intelligence '" & Session("division_no") & "'"

          Set rsIntelligence = Server.CreateObject("ADODB.RecordSet")
          rsIntelligence.Open strSQL, pDbCon, 1, 1  
    
          'response.Write strSQL
          if rsIntelligence.EOF or rsIntelligence.BOF then
	         NoDataIntelligence = True
          Else
	         NoDataIntelligence = False
          end if    

          strSQL = "p_irfh_main_publish '" & Session("division_no") & "'"
          
          Set rsPublish = Server.CreateObject("ADODB.RecordSet")
          rsPublish.Open strSQL, pDbCon, 1, 1  

          'response.Write strSQL
          if rsPublish.EOF or rsPublish.BOF then
	         NoDataPublish = True
          Else
	         NoDataPublish = False
          end if    

          strSQL = "p_irfh_main '" & Session("division_no") & "'"
          'response.Write strSQL
          Set rsData = Server.CreateObject("ADODB.RecordSet")
          rsData.Open strSQL, pDbCon, 1, 1  
        %>
        <div style="font-family:맑은 고딕,Arial;font-size:12pt;color:#3388cc;font-weight:bold;">글로벌정보 BOARD</div>
	    <table cellSpacing="0" cellPadding="0" border="0" ID="Table5" width="100%" align="center">	
	    <tr align=center valign=middle height="25">
	    <td width="100" valign=middle></td>
	    <td width="150"  valign=middle><img src="/images/gi/thumb_warning_off.jpg" height=15 width=15 border=0></td>
	    <td width="150"  valign=middle><img src="/images/gi/thumb_warning_on.jpg" height=15 width=15 border=0></td>
	    </tr>
	    <tr height=3><td colspan=4></td></tr>
	    <tr align=center valign=middle height="25">
	    <td  valign=middle >정보목표</td>
	    <td  valign=middle ><%=rsData("peio_cnt") %>	    </td>
	    <td  valign=middle ><%=rsData("peio_live") %>	    </td>
	    </tr>
	    <tr height=1 bgcolor=#e8e8e8><td colspan=3></td></tr>
	    <tr align=center valign=middle height="25">
	    <td  valign=middle >첩보요소</td>
	    <td  valign=middle ><%=rsData("eei_cnt") %>	    </td>
	    <td  valign=middle ><%=rsData("eei_live") %>	    </td>
	    </tr>
	    <tr height=1 bgcolor=#e8e8e8><td colspan=3></td></tr>
	    <tr align=center valign=middle height="25">
	    <td  valign=middle >임  무</td>
	    <td  valign=middle ><%=rsData("mission_cnt") %>	    </td>
	    <td  valign=middle><%=rsData("mission_live") %>	    </td>
	    </tr>
	    <tr height=1 bgcolor=#e8e8e8><td colspan=3></td></tr>
	    <tr align=center valign=middle height="25">
	    <td  valign=middle >첩  보</td>
	    <td  valign=middle ><%=rsData("information_cnt") %>	    </td>
	    <td  valign=middle ><%=rsData("information_live") %>	    </td>
	    </tr>
	    <tr height=1 bgcolor=#e8e8e8><td colspan=3></td></tr>
	    <tr align=center valign=middle height="25">
	    <td  valign=middle >정  보</td>
	    <td  valign=middle ><%=rsData("intelligence_cnt") %>	    </td>
	    <td  valign=middle><%=rsData("intelligence_live") %>	    </td>
	    </tr>
	    <tr align=center valign=middle height="25">
	    <td valign=middle colspan="3">
		<%
	    if NoDataIntelligence = False then ' 데이터가 있으면 데이터 출력	
        Do While Not rsIntelligence.EOF
        if rsIntelligence("intelligence_type") <> "118" then
        %>       
        <% if rsIntelligence("intelligence_type") = "68" then %>
		      <img src="/images/gi/thumb_notes.jpg" width="12" height="12" border="0">
		<% elseif rsIntelligence("intelligence_type") = "69" then %>
		      <img src="/images/gi/thumb_snowflake.jpg" width="12" height="12" border="0">
		<% elseif rsIntelligence("intelligence_type") = "70" then %>
		      <img src="/images/gi/thumb_dailybrief.jpg" width="12" height="12" border="0">
		<% elseif rsIntelligence("intelligence_type") = "71" then %>
		      <img src="/images/gi/thumb_digest.jpg" width="12" height="12" border="0">
		<% elseif rsIntelligence("intelligence_type") = "72" then %>
		     <img src="/images/gi/thumb_memorandum.jpg" width="12" height="12" border="0">
		<% elseif rsIntelligence("intelligence_type") = "74" then %>
		      <img src="/images/gi/thumb_estimate.jpg" width="12" height="12" border="0">
		<% elseif rsIntelligence("intelligence_type") = "118" then %>
		      <img src="/images/gi/thumb_information.jpg" width="12" height="12" border="0">
		<% end if %> 
	    <%=rsIntelligence("intelligence_cnt")%>&nbsp;
        <%
        end if
        rsIntelligence.MoveNext	
	    Loop                                    
	    set rsIntelligence = nothing
	    end if
        %>	    
	    </td>
	    </tr>
	    <tr height=1 bgcolor=#e8e8e8><td colspan=3></td></tr>
	    </table>	
</div>

