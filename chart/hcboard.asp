  <%
  Set Dbcon = Server.CreateObject("ADODB.Connection")
  DbCon.Open "dsn=healthcaredb;uid=careuser;pwd=care1234;"
  ' �� �б�
  strSQL = "p_config_yyyymm_read '" & request("yyyymm") & "','" & request("date_arrow") & "'"

  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1

  Session("yyyymm") = rsData("yyyymm")
  yyyymm = rsData("yyyymm")

  set rsData = nothing
  %>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<style type="text/css">
${demo.css}
</style>
<script type="text/javascript">
$(function () {
	var axisList;
	var valueList1;
	var valueList2;
	var valueList3;
	var valueList4;

	$.ajax({
		type : "GET",
		url: "hcboard_data.asp",
		dataType : "json",
		//data : "adsId=" + adsId + "&cmd=" + cmd,
		success : function(data) {
		                if (data.isSuccess) {
		                        //alert(data.msg);
		                }

						axisList = data.axisList;			// x�� 1�� ~ 30�� ����
						valueList1 = data.valueList1;		// ����KCal
						valueList2 = data.valueList2;		// Ȱ��+���ʴ��
						valueList3 = data.valueList3;		// BALANCE
						valueList4 = data.valueList4;		// ���ؼ�

						//alert(valueList4);

						$('#container').highcharts({
						chart: {
							zoomType: 'xy'
						},
						title: {
						text: '�Ϻ� ��� ����'
						},
						subtitle: {
							text: '(�ֱ� 15��)'
						},
						xAxis: [{
							categories: axisList,
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
								//color: Highcharts.getOptions().colors[2]
								color: "#0000FF"
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
							layout: 'horizontal',
							align: 'center',
							//x: 120,
							verticalAlign: 'bottom',
							//y: 100,
							floating: false,
							backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
						},
						series: [{
							name: '����KCal',
							type: 'column',
							yAxis: 1,
							data: valueList1,
							tooltip: {
								valueSuffix: ' Į�θ�'
							}
							, color: "#DDDDDD"
						}, {
							name: 'Ȱ��+���ʴ��',
							type: 'column',
							yAxis: 2,
							data: valueList2,
							tooltip: {
								valueSuffix: ' Į�θ�'
							}
							, color: "#AAAAAA"
						}, {
							name: 'BALANCE',
							type: 'spline',
							data: valueList3,
							tooltip: {
								valueSuffix: ' Į�θ�'
			             	}
							,color: "#FF0000"
						}, {
							name: '���ؼ�',
							type: 'spline',
							data: valueList4,
							marker: {
								enabled: false
							},
							dashStyle: 'shortdot',
							tooltip: {
								valueSuffix: ' Į�θ�'
             				}
							, color: "#0000FF"
						}]
					});
		},

		        error : function(e) {
		               alert("ó���� ��ְ� �߻��Ͽ����ϴ�.");
		        }
		});		
});
</script>




<div style="width:100%;">

    <div style="padding:10px;text-align:center;line-height:200%;border:dotted 0px #888888;">
      
<script src="./js/highcharts.js"></script>
<script src="./js/modules/exporting.js"></script>
<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>


    </div>


</div>