<% if session("member_no") > "0"  then %>
<div style="margin:5px 0 5px 0;text-align:center;">
    <div style="padding:5px 0 5px 5px;text-align:left;"><a href="/mypage/charge.asp">ㆍ충전하기</a></div>
    <div style="padding:5px 0 5px 5px;text-align:left;"><a href="/mypage/withdraw.asp">ㆍ환전하기</a></div>
    <div style="padding:5px 0 5px 5px;text-align:left;"><a href="/mypage/bet_history_updown.asp">ㆍ베팅내역</a></div>
    <div style="padding:5px 0 5px 5px;text-align:left;"><a href="/mypage/point_check.asp">ㆍ입금/출금 조회</a></div>
    <div style="padding:5px 0 5px 5px;text-align:left;"><a href="/mypage/directask.asp">ㆍ1:1 문의</a></div>
    <div style="padding:5px 0 5px 5px;text-align:left;"><a href="/mypage/update.asp">ㆍ회원정보수정</a></div>
    <div style="padding:5px 0 5px 5px;text-align:left;"><a href="/mypage/memo.asp">ㆍ쪽지</a></div>

</div>
<% else %>

<div style="margin:5px 0 5px 0;text-align:center;">
    <div style="padding:5px 0 5px 5px;text-align:left;"><a href="/sumember/register_step1.asp">ㆍ회원가입</a></div>
    <div style="padding:5px 0 5px 5px;text-align:left;"><a href="/default.asp">ㆍ로그인</a></div>
    <div style="padding:5px 0 5px 5px;text-align:left;"><a href="/mypage/bet_cancel.asp">ㆍ아이디/비밀번호찾기</a></div>

</div>
<% end if %>

<div style="clear:both;"></div>

