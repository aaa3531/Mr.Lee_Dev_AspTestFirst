<a href="test_set2.asp"><input type="button" value="INDEX"></a>
  <% if Session("ip_count") > "0" then %>
    <table width=1024 align=center>
    <tr>
    <td width=1024 align=center valign=middle style="width:1024px;height:527px;background: url(/Images/home_back7.png) no-repeat;">   
    개발중입니다.
    </td>
    </tr>
    </table>
  <% else %>
    <% if Session("member_no") < "1" then %>
    <table width=1024 align=center border="0" cellpadding="0" cellspacing="0">
    <tr>
    <td width=1024 align=center valign=middle style="width:1024px;height:527px;background: url(/Images/home_back7.png) no-repeat;">  
    <form action="/sumember/login_set.asp" id="formLogin" name="formLogin" method="post">
    <table width="20%" border="0"  style="background-color:#ffffff; opacity:0.6; border-radius:3px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px; " cellpadding="0" cellspacing="0">
    <tr height="20">
    <td width="70%" align="right">
    <div style="margin:3px 0 0 5px;">
    <input type="text" placeholder="이메일" name="member_email" style="width:100%" />
    </div>
    </td>
    <td rowspan="2" width="30%" align="center">
    <input class="bodybutton_on" style="background-color:#47B7AD;"  type="submit" value="로그인" >
    </td>
    </tr>
    <tr height=20">
    <td  align="right">
    <div style="margin:0 0 0 5px;">
    <input type="password" placeholder="비밀번호" name="member_pwd" style="width:100%" />
    </div>
    </td>
    </tr>
    <tr height=25">
    <td colspan="2" align="right" >
    <div>
    <a href="/sumember/register_step1.asp"><span style="padding:5px 15px 5px 5px;font-size:10pt;font-weight:bold; ">회원가입</span></a>
    <a href="#"><span style="padding:5px 15px 5px 5px;font-size:10pt;font-weight:bold;">비밀번호찾기</span></a>
    </div>
    </td>
    </tr>
    </table>
    </form>
    </td>
    </tr>
    </table>
    <% else %>
    <table width=1024 align=center>
    <tr>
    <td width=1024 align=center valign=middle style="width:1024px;height:527px;background: url(/Images/home_back7.png) no-repeat;">  
    <a href="/sumember/logout.asp"><span class="linkbtn">로그아웃</span></a>
    </td>
    </tr>
    </table>
    <% end if %>
  <% end if %>
