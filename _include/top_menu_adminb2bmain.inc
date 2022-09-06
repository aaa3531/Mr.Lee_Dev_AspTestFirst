<?xml version="1.0" encoding="utf-8"?>
<div id="topmenuwhite">
  <div class="blank"></div>
  <ul>
    <li class="sel2">
      <span style="color:#FF6600;font-family:맑은 고딕, Arial;font-size:11pt;font-weight:bold;">ADMIN</span>
    </li>
    <% if menu_main = "site" then %>
    <li class="sel2">
      <a href="/adminb2b/member/">B2B회원관리</a>
    </li>
    <% else %>
    <li class="light2">
      <a href="/adminb2b/member/">B2B회원관리</a>
    </li>
    <% end if %>
    <% if menu_main = "site" then %>
    <li class="sel2">
      <a href="/adminb2b/result/">정산</a>
    </li>
    <% else %>
    <li class="light2">
      <a href="/adminb2b/result/">정산</a>
    </li>
    <% end if %>
  </ul>
</div>
<div style="clear:both;"></div>



