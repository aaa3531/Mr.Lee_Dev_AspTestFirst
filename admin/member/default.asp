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
  
  ' member �б�
  strSQL = "p_sm_member_list "

  'bRtn = dbcon.GetResult(strSQL, rsMember)

  ' ������ �۵��Ǵ� ���
  Set rsMember = Server.CreateObject("ADODB.RecordSet")
  rsMember.cursorlocation = 3
  rsMember.Open strSQL, DbCon, 1, 3

  if rsMember.EOF or rsMember.BOF then
	NoDataMember = True
  Else
	NoDataMember = False
  end if 
  
  '����¡ó������
  page =request("page")
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
	'����¡ó������ �� 
%>

<table width=1024 align=center>
<tr>

<td width=270 valign=top>

  <div style="height:20px;"></div>
  
  <!-- #include virtual="/_include/menu_admin_basic.asp" -->
       
</td>

<td width=754 valign=top>  

<div class="admintitle">�� ADMIN - ȸ������</div>

  <div style="height:10px;"></div>

  <% if member_no > "0" then %>
    <form action="member_update.asp" id="formTool" name="formTool" method="post">
    <input type="hidden" name="member_no" value="<%=member_no %>" ID="Hidden1"> 
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden2"> 	
    <table width="100%"  bgcolor="#dddddd" border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="20%" align="center"><%=member_alias %>
    </td>
    <td width="20%" align="center"><%=member_email %>
    </td>
    <td width="30%" align=center>������
    <input type="text" name="margin_rate" style="width:60px;" class="input" ID="Text1" value="<%=margin_rate %>" >
    </td>
    <td width="15%">
    <% if b2b_flag="1" then %>
    <input type="checkbox" name="b2b_flag" ID="Checkbox2" value="1" checked >B2B�±�
    <% else %>
    <input type="checkbox" name="b2b_flag" ID="Checkbox3" value="1">B2B�±�
    <% end if %>
    </td>
    <td width="15%">
    <% if admin_flag="1" then %>
    <input type="checkbox" name="admin_flag" ID="Text3" value="1" checked >������
    <% else %>
    <input type="checkbox" name="admin_flag" ID="Checkbox1" value="1">������
    <% end if %>
    </td>
    <td width="20%" bgcolor="#dddddd" align="center">
    <input id="submit1" name="submit1" type="submit" value="ȸ������">
    </td>
    </tr>  
    </table>
    </form>
  <% else %>
    <table width="100%"  bgcolor="#dddddd" border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="100%" align="center">�Ʒ����� ȸ���� Ŭ���Ͽ� �����ϼ���
    </td>
    </tr>  
    </table>
  <% end if %>
   
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#e8e8e8">
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">�г���</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">�̸���</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">���¹�ȣ</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">�����ָ�</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">������</td>   
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">�����</td>     
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">ȯ����й�ȣ</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">������,B2B</td>    
    </tr>


    <table width="100%" cellpadding=0 cellspacing=0 border=0>
    	<% if NoDataMember = False then ' �����Ͱ� ������ ������ ��� %>
        <% if FirstPage <> 1 then
	       RowCount = rsMember.PageSize
	       end If ' �����Ͱ� ������ ������ ��� 
           Do While Not rsMember.EOF and RowCount > 0         
           if rsMember("member_no") * 1 - member_no  = 0   then %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#ffffff;">
          <td width="10%" align="center">
          <a href="default.asp?page=<%=cPage%>&member_no=<%=rsMember("member_no") %>"><%=rsMember("member_alias") %></a>
          </td>
          <td width="20%">
          <a href="default.asp?page=<%=cPage%>&member_no=<%=rsMember("member_no") %>"><%=rsMember("member_email") %></a>
          </td>
          <td width="20%" align="center">
          <%=rsMember("account_no") %>
          </td>
          <td width="10%" align="center">
          <%=rsMember("bank_owner") %>
          </td>
          <td width="10%" align="center">
          <%=rsMember("margin_rate") %>
          </td>
          <td width="10%" align="center">
          <%=rsMember("bank_name") %>
          </td>
          <td width="10%" align="center">
          <%=rsMember("withdraw_pwd") %>
          </td>
          <td width="20%" align="center">
          <% if rsMember("admin_flag") = "1" then %> ������ <% end if %>
          <% if rsMember("b2b_flag") = "1" then %> B2B <% end if %>
          </td>
          </tr>
          <% else %>
          
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <td width="10%" align="center">
          <a href="default.asp?page=<%=cPage%>&member_no=<%=rsMember("member_no") %>"><%=rsMember("member_alias") %></a>
          </td>
          <td width="20%">
          <a href="default.asp?page=<%=cPage%>&member_no=<%=rsMember("member_no") %>"><%=rsMember("member_email") %></a>
          </td>
          <td width="20%" align="center">
          <%=rsMember("account_no") %>
          </td>
          <td width="10%" align="center">
          <%=rsMember("bank_owner") %>
          </td>
          <td width="10%" align="center">
          <%=rsMember("margin_rate") %>
          </td>
          <td width="10%" align="center">
          <%=rsMember("bank_name") %>
          </td>
          <td width="10%" align="center">
          <%=rsMember("withdraw_pwd") %>
          </td>
          <td width="20%" align="center">
          <% if rsMember("admin_flag") = "1" then %> ������ <% end if %>
          <% if rsMember("b2b_flag") = "1" then %> B2B <% end if %>
          </td>
          </tr>
          <% end if %>        

        <%                                
        	RowCount = RowCount - 1
        	rsMember.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td>
        	ȸ���� �����ϴ�.
        </td></tr>
        <% end if         
       	set rsMember = nothing
        %> 
    </table>
    <!-- ����¡ ó��-->					
<%if NoDataMember = false Then
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
	<!-- ����¡ ó�� ��-->


  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
