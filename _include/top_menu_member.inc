<!-- #include virtual="/_include/top_common.inc" -->

<!-- #include virtual="/_include/top_menu_main.inc" -->

<div id="submenu2"> 
  <div class="blank"></div>
  <ul> 
    <% if Session("member_no") < "1" then %>
    <li><a href="/gimember/login.asp">�α���</a></li>
    <li><a href="/gimember/register.asp">ȸ������</a></li>
    <li><a href="/gimember/find_pwd.asp">��й�ȣã��</a></li>
    <li><a href="/gicustomer/privacy.asp">����������ȣ��å</a></li>
    <li><a href="/gimember/subscribe.asp">������û</a></li>
    <li><a href="/gimember/">����</a></li>
    <% end if %>  
    <% if Session("member_no") > "0" then %>
    <li><a href="/gimember/change.asp">��������</a></li>
    <li><a href="/gimember/subscribe.asp">������û</a></li>
    <li><a href="/gicustomer/privacy.asp">����������å</a></li>
    <li><a href="#">����</a></li>
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
