
<div class="admintitle">�� ADMIN - <%=menu_desc %></div>
  <div id="bodymenu"> 
    <div class="blank"></div>
    <ul> 
    <% if membermenu = "AREA" then %>
    <li class="sel2">��������</li>
    <% else %>
    <li class="light2"><a href="/giadmin/area/">��������</a></li>
    <% end if %>
    <% if membermenu = "DISTRICT" then %>
    <li class="sel2">��������</li>
    <% else %>
    <li class="light2"><a href="/giadmin/district/">��������</a></li>
    <% end if %>
    <% if membermenu = "CAT" then %>
    <li class="sel2">�����з�</li>
    <% else %>
    <li class="light2"><a href="/giadmin/category/">�����з�</a></li>
    <% end if %>
    <% if membermenu = "COUNTRY" then %>
    <li class="sel2">����</li>
    <% else %>
    <li class="light2"><a href="/giadmin/country/">����</a></li>
    <% end if %>
    </ul>
  </div>
  <div style="clear:both;"></div>
