<!-- #include virtual="/_include/top_common.inc" -->

<!-- #include virtual="/_include/top_menu_main.inc" -->

<div id="submenu2"> 
  <div class="blank"></div>
  <ul> 
    <% if Session("member_no") < "1" then %>
    <li><a href="/gimember/login.asp">로그인</a></li>
    <li><a href="/gimember/register.asp">회원가입</a></li>
    <li><a href="/gimember/find_pwd.asp">비밀번호찾기</a></li>
    <li><a href="/gicustomer/privacy.asp">개인정보보호정책</a></li>
    <li><a href="/gimember/subscribe.asp">구독신청</a></li>
    <li><a href="/gimember/">도움말</a></li>
    <% end if %>  
    <% if Session("member_no") > "0" then %>
    <li><a href="/gimember/change.asp">정보변경</a></li>
    <li><a href="/gimember/subscribe.asp">구독신청</a></li>
    <li><a href="/gicustomer/privacy.asp">개인정보정책</a></li>
    <li><a href="#">도움말</a></li>
    <li></li>
    <li></li>
    <% end if %>  
    <li></li>
    <li></li>
    <li></li>
    <a href="/gimember/subscribe.asp"><img src="/images/subscribe_btn.png" style="border:solid 0px #ffffff;height:20px;width:70px" id="mysubscribe"></a>
  </ul>
</div>

<div style="clear:both;border-bottom:solid 1px #dddddd;"></div>

