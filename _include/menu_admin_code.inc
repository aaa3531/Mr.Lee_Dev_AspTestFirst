
<div class="admintitle">▣ ADMIN - <%=menu_desc %></div>
  <div id="bodymenu"> 
    <div class="blank"></div>
    <ul> 
    <% if membermenu = "AREA" then %>
    <li class="sel2">세계지역</li>
    <% else %>
    <li class="light2"><a href="/giadmin/area/">세계지역</a></li>
    <% end if %>
    <% if membermenu = "DISTRICT" then %>
    <li class="sel2">지역관리</li>
    <% else %>
    <li class="light2"><a href="/giadmin/district/">지역관리</a></li>
    <% end if %>
    <% if membermenu = "CAT" then %>
    <li class="sel2">도서분류</li>
    <% else %>
    <li class="light2"><a href="/giadmin/category/">도서분류</a></li>
    <% end if %>
    <% if membermenu = "COUNTRY" then %>
    <li class="sel2">국가</li>
    <% else %>
    <li class="light2"><a href="/giadmin/country/">국가</a></li>
    <% end if %>
    </ul>
  </div>
  <div style="clear:both;"></div>

