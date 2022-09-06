
      <div class="gnb">
        <ul>
          <li style="margin-right:10px;">
            <ul class="lst_gnb">
              <% if Session("member_no") = "" then %>
              <li class="login">
                  <a href="#">로그인</a>
                <!--<a href="#">로그아웃</a>-->
              </li>
              <li class="intro">
                <a href="/intro/gameintro.asp">게임소개</a>
              </li>
              <% else %>
              <li class="login">
                <a href="/sumember/logout.asp">로그아웃</a>
              </li>
              <li class="qna">
                <a href="/mypage/directask.asp">1:1문의</a>
              </li>
              <li class="charge">
                <a href="/mypage/charge.asp">충전하기</a>
              </li>
              <li class="exchange">
                <a href="/mypage/withdraw.asp">환전하기</a>
              </li>
              <li class="mypage">
                <a href="/mypage/bet_history_updown.asp">MYPAGE</a>
              </li>
              <% end if %>
            </ul>
          </li>
          <li>
            <ul class="lst_nation">
              <li class="korea">
                <span class="flag_normal">
                  <a href="#"><img src="img/ico_korea.png" width="24" height="16" /></a>
                </span>
              </li>
              <li class="usa">
                <span onmouseout="ToggleColor(this,1)" onmouseover="javascript: ToggleColor(this,0);" class="flag_normal">
                  <a href="#"><img src="img/ico_usa.png" width="24" height="16" /></a>
                </span>
              </li>
              <li class="china">
                <span onmouseout="ToggleColor(this,1)" onmouseover="javascript: ToggleColor(this,0);" class="flag_normal">
                  <a href="#"><img src="img/ico_china.png" width="24" height="16" /></a>
                </span>
              </li>
              <li class="japan">
                <span onmouseout="ToggleColor(this,1)" onmouseover="javascript: ToggleColor(this,0);" class="flag_normal">
                  <a href="#"><img src="img/ico_japan.png" width="24" height="16" /></a>
                </span>
              </li>
            </ul>
          </li>
        </ul>
      </div>

      <div class="lnb">
        <h2>
          <a href="/">항하사증권 메뉴</a>
        </h2>
        <ul class="sub_menu">
            <% if menu_main = "intro" then %>
              <li class="mnu" style="background:none">
              <a href="/intro/gameintro.asp" class="mnu_title">게임소개</a>
              </li>
            <% else %>
              <li class="mnu" style="background:none">
              <a href="/intro/gameintro.asp" class="mnu_title">게임소개</a>
              </li>
            <% end if %>
        </ul>
        <ul class="sub_menu sub_menu_v1">
            <% if menu_main = "shop" then %>
            <li class="mnu mnu2">
              <a href="/suupdown/kospi.asp" class="mnu_title">UP & DOWN</a>
            </li>
            <% else %>
            <li class="mnu mnu2">
              <a href="/suupdown/kospi.asp" class="mnu_title">UP & DOWN</a>
            </li>
            <% end if %>
        </ul>
        <ul class="sub_menu sub_menu_v2">
            <% if menu_main = "shop" then %>
            <li class="mnu mnu3">
              <a href="/suitem/" class="mnu_title">종목매치</a>
            </li>
            <% else %>
            <li class="mnu mnu3">
              <a href="/suitem/" class="mnu_title">종목매치</a>
            </li>
            <% end if %>
        </ul>
        <ul class="sub_menu sub_menu_v3">
            <% if menu_main = "shop" then %>
            <li class="mnu mnu4">
              <a href="/sutheme/" class="mnu_title">종목레이스</a>
            </li>
            <% else %>
            <li class="mnu mnu4">
              <a href="/sutheme/" class="mnu_title">종목레이스</a>
            </li>
            <% end if %>
        </ul>
        <ul class="sub_menu sub_menu_v4">
            <% if menu_main = "shop" then %>
            <li class="mnu mnu5">
              <a href="/suresult/" class="mnu_title">게임결과</a>
            </li>
            <% else %>
            <li class="mnu mnu5">
              <a href="/suresult/" class="mnu_title">게임결과</a>
            </li>
            <% end if %>
        </ul>
        <ul class="sub_menu sub_menu_v4">
            <% if menu_main = "shop" then %>
            <li class="mnu mnu5">
              <a href="#" class="mnu_title">증권정보</a>
            </li>
            <% else %>
            <li class="mnu mnu5">
              <a href="#" class="mnu_title">증권정보</a>
            </li>
            <% end if %>
        </ul>
        <ul class="sub_menu sub_menu_v4">
            <% if menu_main = "shop" then %>
            <li class="mnu mnu5">
              <a href="/sucustomer/terms.asp" class="mnu_title">고객센터</a>
            </li>
            <% else %>
            <li class="mnu mnu5">
              <a href="/sucustomer/terms.asp" class="mnu_title">고객센터</a>
            </li>
            <% end if %>
        </ul>
      </div>
