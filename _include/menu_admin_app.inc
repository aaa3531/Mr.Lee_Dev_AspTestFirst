
  <div id="bodymenu"> 
    <div class="blank"></div>
    <ul> 
    <% if membermenu = "ASK" then %>
    <li class="sel2">App신청정보</li>
    <% else %>
    <li class="light2"><a href="/giadmin/app/app_request.asp">App신청정보</a></li>
    <% end if %>
    <% if membermenu = "APP" then %>
    <li class="sel2">App관리</li>
    <% else %>
    <li class="light2"><a href="/giadmin/app/default.asp">App관리</a></li>
    <% end if %>
    <% if membermenu = "MAIL" then %>
    <li class="sel2">Mail알림</li>
    <% else %>
    <li class="light2"><a href="/giadmin/appmail/">Mail알림</a></li>
    <% end if %>
    <% if membermenu = "MENU" then %>
    <li class="sel2">Menu Title</li>
    <% else %>
    <li class="light2"><a href="/giadmin/app/apptitle.asp">Menu Title</a></li>
    <% end if %>
    <% if membermenu = "CONSULT" then %>
    <li class="sel2">상담현황</li>
    <% else %>
    <li class="light2"><a href="/giadmin/app/app_consult.asp">상담현황</a></li>
    <% end if %>
    <% if membermenu = "NOTIFY" then %>
    <li class="sel2">App알림내역</li>
    <% else %>
    <li class="light2"><a href="/giadmin/app/app_notify.asp">App알림내역</a></li>
    <% end if %>
    </ul>
  </div>
  <div style="clear:both;"></div>

