
  <div id="bodymenu"> 
    <div class="blank"></div>
    <ul> 
    <% if membermenu = "ASK" then %>
    <li class="sel2">App��û����</li>
    <% else %>
    <li class="light2"><a href="/giadmin/app/app_request.asp">App��û����</a></li>
    <% end if %>
    <% if membermenu = "APP" then %>
    <li class="sel2">App����</li>
    <% else %>
    <li class="light2"><a href="/giadmin/app/default.asp">App����</a></li>
    <% end if %>
    <% if membermenu = "MAIL" then %>
    <li class="sel2">Mail�˸�</li>
    <% else %>
    <li class="light2"><a href="/giadmin/appmail/">Mail�˸�</a></li>
    <% end if %>
    <% if membermenu = "MENU" then %>
    <li class="sel2">Menu Title</li>
    <% else %>
    <li class="light2"><a href="/giadmin/app/apptitle.asp">Menu Title</a></li>
    <% end if %>
    <% if membermenu = "CONSULT" then %>
    <li class="sel2">�����Ȳ</li>
    <% else %>
    <li class="light2"><a href="/giadmin/app/app_consult.asp">�����Ȳ</a></li>
    <% end if %>
    <% if membermenu = "NOTIFY" then %>
    <li class="sel2">App�˸�����</li>
    <% else %>
    <li class="light2"><a href="/giadmin/app/app_notify.asp">App�˸�����</a></li>
    <% end if %>
    </ul>
  </div>
  <div style="clear:both;"></div>
