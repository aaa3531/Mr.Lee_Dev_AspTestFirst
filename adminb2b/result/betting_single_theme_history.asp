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


  strSQL = "p_sh_game_betting_follower_theme_list '" & Session("member_no") & "','" & yyyymmdd & "'"
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
   menu_desc = "회원 테마별"
%>
<!-- #include virtual="/_include/guide_adminb2b_result.inc" -->
    <table width="100%" border="1" cellpadding="0" cellspacing="0">
    <tr>

  <td width=84 valign=top>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
       <tr height="25" bgcolor="#00856A">
       <td width="40%" align="center" style="border-right:dotted 1px #ffffff; color:#ffffff;">게임일</td>   
       </tr>
    
    	<% if NoDataYyyymmdd = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsYyyymmdd.EOF %>
        <% if rsYyyymmdd("yyyymmdd")  = yyyymmdd then %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47b7ad;">
        <% else %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <% end if %>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;"   >
        <a href="betting_single_theme_history.asp?yyyymmdd=<%=rsYyyymmdd("yyyymmdd") %>">
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
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">아이디</td>  
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">종류</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">테마1</td> 
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">테마2</td>    
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">배당률</td>     
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">베팅금</td>
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">결과</td>
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">배당금</td>  
    </tr>
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsData.EOF    %> 
    <tr height="25" style="border-bottom:dotted 1px #dddddd;">
    <td align="center"><%=rsData("member_id") %></td>   
    <td align="center"><%=rsData("theme_type_desc") %> </td>   
    <td align="center"><%=rsData("theme_name1") %></td>   
    <td align="center"><%=rsData("theme_name2") %></td>    
    <td align="center"><%=rsData("dividend_rate") %></td>    
    <td align="center"><%=rsData("bet_net_amt") %></td>    
    <td align="center"><%=rsData("win_desc") %></td> 
    <% if rsData("dividend_amt") > "0" then %>   
    <td align="center" style="background-color:#47B7AD;"><%=rsData("dividend_amt") %></td>
    <% else %>
    <td align="center"><%=rsData("dividend_amt") %></td>
    <% end if %>    
    </tr>
    <% 	
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="55" >
    <td width="60" align="center" colspan="8">베팅이 없습니다.</td>
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
