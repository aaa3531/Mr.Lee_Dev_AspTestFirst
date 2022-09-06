<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  if request("member_no") = "" then	
    member_no = "0"
  else
	member_no = request("member_no")
    strSQL = "p_sm_member_detail '" & member_no & "' "
    'response.Write strSQL
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      member_email = rs("member_email")
      member_alias = rs("member_alias")
      admin_flag = rs("admin_flag")
      b2b_flag = rs("b2b_flag")
      margin_rate = rs("margin_rate")
    end if 
    set rs = nothing
  end if 
  
  ' member 읽기
  strSQL = "p_sm_member_list "

  'bRtn = dbcon.GetResult(strSQL, rsMember)

  ' 페이지 작동되는 방식
  Set rsMember = Server.CreateObject("ADODB.RecordSet")
  rsMember.cursorlocation = 3
  rsMember.Open strSQL, DbCon, 1, 3

  if rsMember.EOF or rsMember.BOF then
	NoDataMember = True
  Else
	NoDataMember = False
  end if 
  
  '페이징처리관련
  page =Cint(request("page"))
  If NoDataMember = False then
		Cus_pageSize = 10
		rsMember.PageSize = Cus_pageSize

		pagecount=rsMember.pagecount
		totalRecord = rsMember.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsMember.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsMember.PageSize) + 1)

		if page > lastpg then
			page = lastpg
		end If

	end if
	'페이징처리관련 끝 
%>

  <div style="height:20px;"></div>
<table width=1024 align=center>
<tr>

<td width=270 valign=top>

  
  <!-- #include virtual="/_include/menu_admin_site.asp" -->
       
</td>

<td width=754 valign=top>  

<% membermenu = "SPOINT"
   menu_desc = "적립금(Point) 기준 설정"
%>
<!-- #include virtual="/_include/guide_admin_site.inc" -->

  <div style="height:10px;"></div>
   
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="30" bgcolor="#ffffff">
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">▶ 적립금 기준설정</td>    
    <td width="40%"  align="left" style="border-right:dotted 1px #ffffff;">* 적립금 1point는 현금 1원과 동일합니다.</td> 
    <td width="40%"  align="center" style="border-right:dotted 1px #ffffff;"></td>        
    </tr>
    
    <tr height="30" bgcolor="#e8e8e8" >
    <td width="20%" align="center" style="border-right:dotted 1px #000000;">회원가입 적립금</td>    
    <td width="50%"  align="left" style="border-right:dotted 1px #e8e8e8;">
    <input type=radio>사용안함</input>&nbsp;&nbsp;&nbsp;
    <input type=radio checked>사용</input>
    <input type="text"  style="width:120px;" value="3000">&nbsp;Point</input>
    </td>
    <td width="30%"  align="center" style="border-right:dotted 1px #e8e8e8;"></td>        
    </tr>
    
    <tr height="30" bgcolor="#e8e8e8">
    <td width="20%" align="center" style="border-right:dotted 1px #000000;">적립금 사용단위</td>    
    <td width="60%"  align="left" style="border-right:dotted 1px #e8e8e8;">
    <input type=radio>제한없음</input>&nbsp;&nbsp;&nbsp;
    <input type=radio checked>기본사용단위</input>
    <input type="text"  style="width:120px;" value="1000">&nbsp;Point</input>
    </td>
    <td width="20%"  align="center" style="border-right:dotted 1px #e8e8e8;"></td>        
    </tr>
    
    <tr height="30" bgcolor="#e8e8e8">
    <td width="20%" align="center" style="border-right:dotted 1px #000000;">적립금 사용범위</td>    
    <td width="80%"  align="left" style="border-right:dotted 1px #e8e8e8;">
    <input type=radio>제한없음</input>
    <input type=radio checked>기본사용단위</input>
    최소<input type="text" style="width:120px;" value="1000">&nbsp;Point</input>
    ~ 최대<input type="text" style="width:120px;" value="30000">&nbsp;Point</input>
    </td>    
    </tr>
    </table>

    <div align="center" style="padding:30px;"><a href="#"><span class="linkbtn">저장</span></a></div>


</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
