<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%


  if request("charge_no") <> "" then	
	charge_no = request("charge_no")
    end if

  strSQL = "p_sh_charge_list   '" & charge_no & "'"

    'bRtn = dbcon.GetResult(strSQL, rsGrade)

     ' 페이지 작동되는 방식
     Set rsChargeList = Server.CreateObject("ADODB.RecordSet")
     rsChargeList.cursorlocation = 3
     rsChargeList.Open strSQL, DbCon, 1, 3
    
     if rsChargeList.EOF or rsChargeList.BOF then
    	NoDataChargeList = True
      Else
    	NoDataChargeList = False
     end if 

     
  '페이징처리관련
  page =Cint(request("page"))
  If NoDataChargeList = False then
		Cus_pageSize = 10
		rsChargeList.PageSize = Cus_pageSize

		pagecount=rsChargeList.pagecount
		totalRecord = rsChargeList.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsChargeList.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsChargeList.PageSize) + 1)

		if page > lastpg then
			page = lastpg
		end If

	end if
	'페이징처리관련 끝 


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
  
  ' member 읽기
  strSQL = "p_sh_point_ledger_detail '" & member_no & "'"

  'bRtn = dbcon.GetResult(strSQL, rsMember)

  ' 페이지 작동되는 방식
  Set rsMoney = Server.CreateObject("ADODB.RecordSet")
  rsMoney.Open strSQL, DbCon, 1, 1

  if rsMoney.EOF or rsMoney.BOF then
	NoDataMoney = True
  Else
	NoDataMoney = False
  end if   
    
  
    strSQL = "p_sh_charge_detail '" & request("charge_no") & "'"
    'response.Write strSQL
    'response.end
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rsDetail = Server.CreateObject("ADODB.RecordSet")
    rsDetail.Open strSQL, DbCon, 1, 1
  
    if NOT rsDetail.EOF and NOT rsDetail.BOF then
      member_no = rsDetail("member_no")
      charge_name = rsDetail("charge_name")
      charge_amt = rsDetail("charge_amt")
      register_date = rsDetail("register_date")
    end if 
    
%>

<div style="height:20px;"></div>
<table width=1024 align=center>
<tr>

<td width=270 valign=top>
  
  <!-- #include virtual="/_include/menu_admin_customer.asp" -->
       
</td>

<td width=754 valign=top>  

<% membermenu = "MONEY"
   menu_desc = "회원입금관리"
%>
<!-- #include virtual="/_include/guide_admin_customer.inc" -->

  <table width="100%" border="1" cellpadding="0" cellspacing="0">
  <tr>
  <td width="754" valign="top"> 

  



<table style="border-bottom:dotted 1px; background-color:#ffffff;" width="100%" cellpadding="0" cellspacing="0">
  <tr>
<td width=754 valign=top >  
  <% if charge_no > "0" then %>
    <form action="point_set.asp" id="formTool" name="formTool" method="post">
    <input type="hidden" name="charge_no" value="<%=charge_no %>" ID="Hidden1"> 
    <input type="hidden" name="member_no" value="<%=member_no %>" ID="Hidden3"> 
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden2"> 	
    <table width="100%"  bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="15%" align="center" style="color:#00856a;font-weight:bold;">입금자 : <%=charge_name %>
    </td>
    <td width="15%" align="center" style="color:#00856a;font-weight:bold;">입금신청액 : <%=charge_amt %>
    </td>
    <td width="30%" align="center" style="color:#00856a;font-weight:bold;">입금신청시간 : <%=register_date %>
    </td>
    <td width="20%" align=center>
    <input type="text" name="charge_amt" style="width:100px;text-align:center;" class="input" ID="Text1" value="<%=charge_amt %>" >
    <input id="submit1" name="submit1" type="submit" value="적립">
    </td>
    </tr>  
    </table>
    </form>
 

  <% else %>
  <div style="height:20px; padding:5px; text-align:center;background-color:#ffffff;">  
    회원을 선택하세요.
  </div>
  <% end if %> 
  
  </td>
  </tr>
  </table>



   
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#dddddd;">
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">입금자명</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">입금신청액</td>   
    <td width="40%"  align="center" style="border-right:dotted 1px #ffffff;">입금시간</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">상태</td>    
    </tr>
    	<% if NoDataChargeList = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsChargeList.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsChargeList.EOF and RowCount > 0 %>   
          <% if rsChargeList("charge_no") * 1 - charge_no  = 0 then %>    
          <tr height="25" style="border-bottom:dotted 1px #dddddd; background-color:#47B7AD;">
          <% else %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <% end if %> 
          <td width="20%" align="center">
          <a href="default.asp?page=<%=cPage%>&charge_no=<%=rsChargeList("charge_no") %>"><%=rsChargeList("charge_name") %></a>
          </td>
          <td width="20%"  align="center">
          <a href="default.asp?page=<%=cPage%>&charge_no=<%=rsChargeList("charge_no") %>"><%=rsChargeList("charge_amt") %></a>
          </td>
          <td width="40%" align="center">
          <%=rsChargeList("register_date") %>
          </td>
          <td width="20%" align="center">
          <% if status_flag = 0 then %>확인중
          <% else %>입금완료
          <% end if %>
          </td>
          </tr>           

        <%                                
        	RowCount = RowCount - 1
        	rsChargeList.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td style="height:25; padding:5px;text-align:center;background-color:#47B7AD; font-weight:bold;" colspan="4">
        	입금내역이 없습니다.
        </td></tr>
        <% end if         
       	set rsChargeList = nothing
        %> 
    </table>
    <!-- 페이징 처리-->					
<%if NoDataChargeList = false Then
	Cus_Tar = "peio_no=" & peio_no 
%>
<!--#include virtual="/_include/asp_page_function.asp"-->
<table cellSpacing="0" cellPadding="0" border="0" ID="Table9" width="100%">
	<tr>
		<td align="center">
			<table border="0" width="100%" cellpadding="0" cellspacing="0" ID="Table11" height="20">
				<tr>
					<td height="20" align="center" valign="middle">
<%
	Response.Write ShowPageBar("default.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>	
	<%end if%>		
	<!-- 페이징 처리 끝-->  
</td>
</tr>
</table>


</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
