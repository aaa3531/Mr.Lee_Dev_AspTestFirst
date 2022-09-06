<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  if request("parameter_cd") <> "" then	
	parameter_cd = request("parameter_cd")
    strSQL = "p_sm_parameter_detail '" & parameter_cd & "' "
    'response.Write strSQL
    'response.end
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rsDetail = Server.CreateObject("ADODB.RecordSet")
    rsDetail.Open strSQL, DbCon, 1, 1
  
    if NOT rsDetail.EOF and NOT rsDetail.BOF then
      parameter_cd = rsDetail("parameter_cd")
      parameter_desc = rsDetail("parameter_desc")
      parameter_value = rsDetail("parameter_value")
      default_value = rsDetail("default_value")
      parameter_type = rsDetail("parameter_type")
    end if 
    set rsDetail = nothing
  end if 


  if request("prameter_cd") <> "" then	
	prameter_cd = request("prameter_cd")
  end if 
  
  ' ip 읽기
  strSQL = "p_sm_parameter_list"
  
  'bRtn = dbcon.GetResult(strSQL, rsIP)

  ' 페이지 작동되는 방식
  Set rsParameter = Server.CreateObject("ADODB.RecordSet")
  rsParameter.cursorlocation = 3
  rsParameter.Open strSQL, DbCon, 1, 3

  if rsParameter.EOF or rsParameter.BOF then
	NoDataParameter = True
  Else
	NoDataParameter = False
  end if 
  
  'response.Write strSQL
  'response.End


  '페이징처리관련
  page =cint(request("page"))
  'response.Write page
  If NoDataParameter = False then
		Cus_pageSize = 20
		rsParameter.PageSize = Cus_pageSize

		pagecount=rsParameter.pagecount
		totalRecord = rsParameter.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsParameter.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsParameter.PageSize) + 1)
        'response.write lastpg
		if page > lastpg then
			page = lastpg
		end If
        
        'response.write page
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

<% membermenu = "PARAMETER"
   menu_desc = "파라메터관리"
%>
<!-- #include virtual="/_include/guide_admin_site.inc" -->

  <div style="margin:10px 0 0 0;padding: 5px;background-color:#ffffff;">
  <% if parameter_cd > "0" then %>
    <form action="parameter_update.asp" id="formTool" name="formTool" method="post">
    <input type="hidden" name="parameter_cd" value="<%=parameter_cd %>" ID="Hidden1">
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden2"> 	
    <table width="100%"   border="0" cellpadding="0" cellspacing="0">
    <tr height="25">
    <td width="30%" align="center">그룹
    <input type="text" name="parameter_type" style="width:100px;" class="input" ID="Text2" value="<%=parameter_type %>">&nbsp;
    </td>
    <td width="50%" align="left" colspan="2">설명
    <input type="text" name="parameter_desc" style="width:300px;" class="input" ID="Text6" value="<%=parameter_desc %>">&nbsp;
    </td>
    <td width="10%" align="center" rowspan="2">
    <a href="default.asp">[NEW]</a>&nbsp;
    <input id="submit1" name="submit1" type="submit" value="수정">
    </td>
    </tr>  
    <tr height="25">
    <td width="10%" align="center" style="color:#ff6600; font-weight:bold;"> 
    <%=parameter_cd %>
    </td>
    <td width="30%" align="left">VALUE
    <input type="text" name="parameter_value" style="width:80px;" class="input" ID="Text5" value="<%=parameter_value %>" >&nbsp;
    </td>
    <td width="50%" align="center">초기값
    <input type="text" name="default_value" style="width:80px;" class="input" ID="Text7" value="<%=default_value %>" >&nbsp;
    </td>
    </tr>  
    </table>
    </form>
  <% else %>
    <form action="parameter_insert.asp" id="form1" name="formTool" method="post">
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden3"> 	
    <table width="100%"   border="0" cellpadding="0" cellspacing="0">
    <tr height="25">
    <td width="30%" align="center">그룹
    <input type="text" name="parameter_type" style="width:100px;" class="input" ID="Text4" value="<%=parameter_type %>">&nbsp;
    </td>
    <td width="60%" align="center" colspan="2">설명
    <input type="text" name="parameter_desc" style="width:300px;" class="input" ID="Text1" value="<%=parameter_desc %>">&nbsp;
    </td>
    <td width="10%"   align="left" rowspan="2">
    <input id="submit3" name="submit1" type="submit" value="입력">
    </td>
    </tr> 
    <tr height="25">
    <td width="20%" align="center">코드
    <input type="text" name="parameter_cd" style="width:100px;" class="input" ID="Text10" value="<%=parameter_cd %>">&nbsp;
    </td>
    <td width="20%" align="center">VALUE
    <input type="text" name="parameter_value" style="width:80px;" class="input" ID="Text11" value="<%=parameter_value %>" >&nbsp;
    </td>
    <td width="20%" align="center">초기값
    <input type="text" name="default_value" style="width:80px;" class="input" ID="Text13" value="<%=default_value %>" >&nbsp;
    </td>
    </tr>  
    </table>
    </form>
  <% end if %>
  </div>
   
    <table width=100% cellpadding=0 cellspacing=0 border=0>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#dddddd;">
          <td width="15%" align="center">타입</td>
          <td width="15%" align="center">코드</td>
          <td width="40%" align="center">설명</td>
          <td width="10%" align="center">VALUE</td>
          <td width="10%" align="center">초기값</td>
          <td width="10%" align="center">삭제</td>
          </tr>
    	<% 
    	if NoDataParameter = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsParameter.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsParameter.EOF and RowCount > 0  %>
          <tr height="25" style="border-bottom:solid 1px #dddddd;">
          <td width="15%" align="center">
          <% if rsParameter("parameter_type") <> parameter_type_old then %>
          <a href="default.asp?parameter_cd=<%=rsParameter("parameter_cd") %>"><%=rsParameter("parameter_type") %></a>
          <% end if %>
          </td>
          <td width="15%" align="center">
          <a href="default.asp?parameter_cd=<%=rsParameter("parameter_cd") %>"><%=rsParameter("parameter_cd") %></a>
          </td>
          <td width="40%" align="left">
          <a href="default.asp?parameter_cd=<%=rsParameter("parameter_cd") %>"><%=rsParameter("parameter_desc") %></a>
          </td>
          <td width="10%" align="center">
          <%=rsParameter("parameter_value") %>
          </td>
          <td width="10%" align="center">
          <%=rsParameter("default_value") %>
          </td>
          <td width="20%" align="center">
          <a href="parameter_delete.asp?parameter_cd=<%=rsParameter("parameter_cd") %>"><span class="linkbtn">X</span></a>
          </td>
          </tr>
        <%                                
        	RowCount = RowCount - 1
            parameter_type_old = rsParameter("parameter_type")
        	rsParameter.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td>
        	파라메터가 없습니다.
        </td></tr>
        <% end if         
       	set rsParameter = nothing
       	
        %> 
    </table>
    <!-- 페이징 처리-->					
<%if NoDataParameter = false Then
	Cus_Tar = "key=" & request("key") 
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
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
