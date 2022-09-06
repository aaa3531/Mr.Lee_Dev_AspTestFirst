<!-- #include virtual="/_include/top_menu_adminb2b.inc" -->
<!-- #include virtual="/_include/connect.inc" -->

<%       

  strSQL = "p_sm_gameday_read "

  'response.write Session("grade_cd")
  'response.End
  
  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1

  if NOT rs.EOF and NOT rs.BOF then
    game_day = rs("game_day")
  end if   

  set rs = nothing

  if request("yyyymmdd") <> "" then  
	yyyymmdd = request("yyyymmdd")
  else
	yyyymmdd = game_day
  end if 

  'calculate_list 읽기
  strSQL = "p_sh_betting_yyyymmdd_list "

  Set rsYyyymmdd = Server.CreateObject("ADODB.RecordSet")
  rsYyyymmdd.Open strSQL, DbCon, 1, 1

  if rsYyyymmdd.EOF or rsYyyymmdd.BOF then
	NoDataYyyymmdd = True
  Else
	NoDataYyyymmdd = False
  end if   
  'response.write strSQL
  'response.End


  strSQL = "p_sh_game_betting_follower_list '" & Session("member_no") & "','" & yyyymmdd & "'"
  'response.write strSQL
  'response.End
  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if rsData.EOF or rsData.BOF then
	NoData = True
  Else
	NoData = False
  end if  
%>

  <div style="height:20px;"></div>
    <table width="1024" border="0" cellpadding="0" cellspacing="0">
<tr>

<td width=270 valign=top>

<!-- #include virtual="/_include/menu_adminb2b_result.asp" -->
</td>
<td width=754> 
<% membermenu = "BETHISTORY"
   menu_desc = "회원정산"
%>
<!-- #include virtual="/_include/guide_adminb2b_result.inc" -->
    <table width="100%" border="1" cellpadding="0" cellspacing="0">
    <tr>

  <td width=84 valign=top>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
       <tr height="25" bgcolor="#00856A">
       <td width="40%" align="center" style="border-right:dotted 1px #ffffff; color:#ffffff;">게임일</td>   
       </tr>
    
    	<% if NoDataYyyymmdd = False then ' 데이터가 있으면 데이터 출력 
        %>
        <% Do While Not rsYyyymmdd.EOF %>
        <% if rsYyyymmdd("yyyymmdd")  = yyyymmdd then %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47b7ad;">
        <% else %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <% end if %>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;"   >
        <a href="default.asp?yyyymmdd=<%=rsYyyymmdd("yyyymmdd") %>">
        <span style="font-weight:bold; color:#3388CC;"><%=rsYyyymmdd("yyyymmdd") %></span></a>
        </td>
        </tr>
        <%                              
        	rsYyyymmdd.MoveNext
	        Loop 
        %>
		<% else %>
		<div style="padding:10px;text-align:center;">
			게임일이 없습니다.
        </div>
        <% end if         
       	set rsYyyymmdd = nothing
        %>   
    </table>
  
  </td>


<td width=670 valign=top>  


    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#00856A">
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">구분</td> 
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">본사</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">부본사</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">총판</td>    
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">부총판</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">매장</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">사용자</td>    
    </tr>
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 
          fee_amt1_total = 0
          fee_amt2_total = 0
          fee_amt3_total = 0
          fee_amt4_total = 0
          fee_amt5_total = 0 %>
    <% 
       Do While Not rsData.EOF    %> 
    <tr height="25"  style="border-bottom:solid 1px #888888;">  
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;">ID(마진율)</div>
    <div style="padding:3px 0 3px 0; text-align:center;">수익</div>
    </td>
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;">
    <% if  parent_old1 <> rsData("parent_id1") then %>
    <%=rsData("parent_id1") %> (<%=rsData("margin_rate1") %>)
    <% else %>
    "
    <% end if %>
    </div>
    <div style="padding:3px 0 3px 0; text-align:center;color:#3388cc;font-weight:bold;"><%=rsData("fee_amt1") %></div>
    </td> 
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;">
    <% if  parent_old2 <> rsData("parent_id2") then %>
    <%=rsData("parent_id2") %> (<%=rsData("margin_rate2") %>)
    <% else %>
    "
    <% end if %>
    </div>
    <div style="padding:3px 0 3px 0; text-align:center;color:#3388cc;font-weight:bold;"><%=rsData("fee_amt2") %></div>
    </td>   
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;">
    <% if  parent_old3 <> rsData("parent_id3") then %>
    <%=rsData("parent_id3") %> (<%=rsData("margin_rate3") %>)
    <% else %>
    "
    <% end if %>
    </div>
    <div style="padding:3px 0 3px 0; text-align:center;color:#3388cc;font-weight:bold;"><%=rsData("fee_amt3") %></div>
    </td>   
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;">
    <% if  parent_old4 <> rsData("parent_id4") then %>
    <%=rsData("parent_id4") %> (<%=rsData("margin_rate4") %>)
    <% else %>
    "
    <% end if %>
    </div>
    <div style="padding:3px 0 3px 0; text-align:center;color:#3388cc;font-weight:bold;"><%=rsData("fee_amt4") %></div>
    </td>   
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;">
    <% if  parent_old5 <> rsData("parent_id5") then %>
    <%=rsData("parent_id5") %> (<%=rsData("margin_rate5") %>)
    <% else %>
    "
    <% end if %>
    </div>
    <div style="padding:3px 0 3px 0; text-align:center;color:#3388cc;font-weight:bold;"><%=rsData("fee_amt5") %></div>
    </td>   
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsData("member_id") %></div>
    <div style="padding:3px 0 3px 0; text-align:center;color:#000000;font-weight:bold;"><%=rsData("fee_amt") %></div>
    </td>       
    </tr>

    <% 
        fee_amt1_total = fee_amt1_total + rsData("fee_amt1")
        fee_amt2_total = fee_amt2_total + rsData("fee_amt2")
        fee_amt3_total = fee_amt3_total + rsData("fee_amt3")
        fee_amt4_total = fee_amt4_total + rsData("fee_amt4")
        fee_amt5_total = fee_amt5_total + rsData("fee_amt5")
    if parent_old5 <> rsData("parent_id5") then %>
    <tr height="35"  style="border-bottom:solid 1px #888888; background-color:#ffffff;" >  
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;">수익합계</div>
    </td>
    <td align="center" style="font-weight:bold; color:#ff6600;"></td> 
    <td align="center" style="font-weight:bold; color:#ff6600;"></td>   
    <td align="center" style="font-weight:bold; color:#ff6600;"></td>   
    <td align="center" style="font-weight:bold; color:#ff6600;"></td>   
    <td align="center" style="font-weight:bold; color:#ff6600;"><%=fee_amt5_total %></td>   
    <td align="center"> </td>       
    </tr>
    <% fee_amt5_total = 0
    end if %>
    
    <% 	
        parent_old1 = rsData("parent_id1")
        parent_old2 = rsData("parent_id2")
        parent_old3 = rsData("parent_id3")
        parent_old4 = rsData("parent_id4")
        parent_old5 = rsData("parent_id5")
        rsData.MoveNext
	    Loop 
    %>
    <tr height="35"  style="border-bottom:solid 1px #888888; background-color:#ffffff;" >  
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;">수익합계</div>
    </td>
    <td align="center" style="font-weight:bold; color:#ff6600;"><%=fee_amt1_total %></td> 
    <td align="center" style="font-weight:bold; color:#ff6600;"><%=fee_amt2_total %></td>   
    <td align="center" style="font-weight:bold; color:#ff6600;"><%=fee_amt3_total %></td>   
    <td align="center" style="font-weight:bold; color:#ff6600;"><%=fee_amt4_total %></td>   
    <td align="center" style="font-weight:bold; color:#ff6600;"><%=fee_amt5_total %></td>   
    <td align="center"> </td>       
    </tr>
	<% else %>
	<tr height="45">
    <td width="60" align="center" colspan="6">데이터가 없습니다.</td>
    </tr>
    <% end if         
    set rsData = nothing
    %>    
    </table>

  
    </td>
    </tr>
    </table>
    <div style="height:20px;"></div>
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
