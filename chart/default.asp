
<script type="text/javascript" language="JavaScript" src="http://www.globalintelligence.kr/_script/connect.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<style type="text/css">
${demo.css}
</style>
<script type="text/javascript">
$(function () {
    $('#container').highcharts({
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: '�Ϻ� Ȱ���� ���� (SAMPLE)'
        },
        subtitle: {
            text: '2015�� 3��'
        },
        xAxis: [{
            categories: ['1��', '2��', '3��', '4��', '5��', '6��',
                '7��', '8��', '9��', '10��', '11��', '12��', '13��', '14��', '15��', '16��', '17��', '18��',
                '19��', '20��', '21��', '22��', '23��', '24��', '25��', '26��', '27��', '28��', '29��', '30��'],
            crosshair: true
        }],
        yAxis: [{ // Primary yAxis
            labels: {
                format: '{value}',
                style: {
                    color: Highcharts.getOptions().colors[2]
                }
            },
            title: {
                text: 'BALANCE',
                style: {
                    color: Highcharts.getOptions().colors[2]
                }
            }
        }, { // Secondary yAxis
            title: {
                text: '����KCal',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            labels: {
                format: '{value}',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            opposite: true
        }, { // Secondary yAxis
            title: {
                text: 'Ȱ��+���ʴ��',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            labels: {
                format: '{value}',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            x: 120,
            verticalAlign: 'top',
            y: 100,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
        },
        series: [{
            name: '����KCal',
            type: 'column',
            yAxis: 1,
            data: [2400, 2300, 2200, 1700, 1750, 1730, 1900, 2400, 2500, 2300, 2100, 2150, 2400, 2300, 2200, 1700, 1750, 1730, 1900, 2400, 2500, 2300, 2100, 2150, 1900, 2400, 2500, 2300, 2100, 2150],
            tooltip: {
                valueSuffix: ' Į�θ�'
            }

        }, {
            name: 'Ȱ��+���ʴ��',
            type: 'column',
            yAxis: 2,
            data: [100, 120, 150, 80, 300, 280, 120, 110, 190, 210, 135, 140, 100, 120, 150, 80, 300, 280, 120, 110, 190, 210, 135, 140, 120, 110, 190, 210, 135, 140],
            tooltip: {
                valueSuffix: ' Į�θ�'
            }

        }, {
            name: 'BALANCE',
            type: 'spline',
            data: [300, 500, -50, 345, 422, -125, -78, -25, 780, 155, -80, -54, -30, 25, 77, -38, 77, -38, 77, -38, 544, 322, 77, -38, 77, -38, -177, -38, 77, -38],
            tooltip: {
                valueSuffix: ' Į�θ�'
            }
        }, {
            name: '���ؼ�',
            type: 'spline',
            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            marker: {
                enabled: false
            },
            dashStyle: 'shortdot',
            tooltip: {
                valueSuffix: ' Į�θ�'
            }
        }]
    });
});
</script>


<%      

  Set Dbcon = Server.CreateObject("ADODB.Connection")
  DbCon.Open "dsn=healthcaredb;uid=careuser;pwd=care1234;"

   strSQL = "p_hch_info_home_read "

   Set rsHcinfo = Server.CreateObject("ADODB.RecordSet")
   rsHcinfo.Open strSQL, DbCon, 1, 1
         
   'response.Write strSQL
   if rsHcinfo.EOF or rsHcinfo.BOF then
          NoDataHcinfo = True
   Else
	      NoDataHctinfo = False
   end if         
       
  %>

<div id="homebody">

<table width=1024 align=center>
<tr>

<td width=754 valign=top>  

<div style="height:16pt;"></div>  

<script src="./js/highcharts.js"></script>
<script src="./js/modules/exporting.js"></script>
<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>

<div style="height:16pt;"></div>  


<div style="margin:10px 0 0 0;padding:0 5px 0 0;">
  <div style="margin:15px 0 0 0;padding:5px;border:inlet 1px #888888;background-color:#ffffff;border-radius:3px;box-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);">
    	<%   
    	if NoDataHcinfo = False then     	
    	Do While Not rsHcinfo.EOF
        %>
	    <div style="border-right:dotted 0px #888888;padding:10px 5px 10px 5px;line-height:200%;">	    
	    <span style="font-family:���� ���,Arial;color:#0000ff;font-size:18px;font-weight:bold;"><%=rsHcinfo("report_name")%></span>
	    <span style="font-family:���� ���,Arial;color:#aaa;font-weight:normal;font-size:14px;margin:3px 0 3px 15px;"><%=mid(rsHcinfo("register_date"),1,10) %>, <%=rsHcinfo("cat_desc")%></span>
	    </div>
        <% if rsHcinfo("report_summary") <> "" then %>
 	    <div style="border-right:dotted 0px #888888;padding:10px 5px 10px 5px;line-height:200%;">	 
 	    <%=rsHcinfo("report_summary") %>   
	    </div>
	    <% end if %>
        <%
        rsHcinfo.MoveNext
	    Loop                                    
	    else
	    %>
	    <div style="text-align:center;padding:10px;">
	    <span style="font-family:���� ���,Arial;color:#f60;font-weight:bold;">������ �����ϴ�.</span>
	    </div>
	    <%
	    end if
	    set rsHcinfo = nothing
        set DbCon = nothing
	    %>
  </div>
<div style="margin:5px 0 0 0;line-height:180%;padding:0 3px 3px 3px;">
<a href="/hcinfo/"><span style="font-family:���� ���,Arial;color:#283f01;font-weight:bold;font-size:14px;">�ｺ�ɾ����� ��</span></a>
</div>
</div>



<div style="height:10px;clear:both;"></div>


        
</td>



<td width=270 valign=top>

</td>

</tr>
</table>


<div class="rightbreak10"></div>
