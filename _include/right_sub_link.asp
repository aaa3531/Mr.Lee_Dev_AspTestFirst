<style>
#rightsub img 
{
    border:0;
    width:32px;
    height:30px;
	border-radius:5px;
	transition-property:background-color, border-radius;
    -webkit-transition-property:background-color, border-radius;
    -moz-transtion-property:background-color, border-radius;
    transition-duration:3s; 
    -webkit-transition-duration:3s;
    -moz-transition-duration:3s;
}
#rightsub:hover img {
	background-color:#888888;
	border-radius:5px;
    transform:rotate(360deg);
    -webkit-transform:rotate(360deg);   
    -moz-transform:rotate(360deg);
    -o-transform:rotate(360deg);
    -ms-transform:rotate(360deg);
}

#postbox {
  transition: all 10s linear;
  -webkit-transition: all 3s linear;  
  -moz-transition: all 0.5s ease;
  -o-transition: all 0.5s ease;
  -ms-transition: all 0.5s ease;
}
#postbox:hover {
    transform:rotate(360deg);
    -webkit-transform:rotate(360deg);   
    -moz-transform:rotate(360deg);
    -o-transform:rotate(360deg);
    -ms-transform:rotate(360deg);
}
</style>

<div id="rightsub">
<div class="left">
	<a href="http://blog.naver.com/songpanet/"><img src="/images/naver_blog.jpg"></a>		
	<a href="http://www.facebook.com/songpanet/"><img src="/images/facebook.png"></a>		
	<a href="http://www.twitter.com/foodcredit/"><img src="/images/twitter.png"></a>
</div>
<div class="right">
	<a href="/giprosuming/"><img src="/images/book_thumb.png"  title="책구매"></a>
	<a href="/gianalysis/report_result.asp"><img src="/images/report_thumb.png"  title="보고서"></a>
	<a href="/giletter/iletter.asp"><img src="/images/post_thumb1.png"  title="정보레터" id="postbox"></a>
</div>
</div>
<div style="clear:both;"></div>
