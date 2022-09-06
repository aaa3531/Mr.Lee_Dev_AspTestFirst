<%@ Language=VBScript %>
<%
    Dim UploadForm
    Dim TempFilePath
    Dim FilePath
    
    'DEXT.FileUpload ��ü ����
    Set UploadForm = Server.CreateObject("DEXT.FileUpload")
    
    'AutoMakeFolder �� TRUE�� �����ϸ� DefaultPath, SaveAs ���� ������ ������ �������� ���� ��� ������ �ڵ����� �����Ѵ�.
    UploadForm.AutoMakeFolder = True
    UploadForm.DefaultPath ="C:\inetpub\wwwroot\hhs\images\stocktest"

    'TempFilePath�� ������ �����ϱ� ���� ���ؾ� �Ѵ�. ������ �����ϰ� ���� Temp File�� �����ȴ�.
    TempFilePath = UploadForm("file").TempFilePath

    'Save �޼ҵ��� ù ��° ���ڴ� ����� ��δ�. �⺻���� DefaultPath�� ������ �����̴�.
    'Save �޼ҵ��� �� ��° ���ڴ� ���� ������ ������ ��� ��� �������� �����̴�. �⺻���� True(������ ���)�̴�.
    FilePath = UploadForm("file").Save("C:\inetpub\wwwroot\hhs\images\stocktest", False)
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <meta content="text/html; charset=ks_c_5601-1987" http-equiv="content-Type" />
    <link rel="Stylesheet" type="text/css" href="../../../Supports/Styles/Default.css" /> 
</head>
<body>
	<div class="leftTopIndentOne">
        <p>TempFilePath :          <%= TempFilePath                            %></p>
        <p>Original Path :         <%= UploadForm("file").FilePath             %></p>
        <p>Upload Path :           <%= FilePath                                %></p>
        <p>File Size :             <%= UploadForm("file").FileLen              %> bytes</p>
        <p>MimeType :              <%= UploadForm("file").MimeType             %></p>
        <p>LastSavedFileName :     <%= UploadForm("file").LastSavedFileName    %></p>
        <p>LastSavedFilePath :     <%= UploadForm("file").LastSavedFilePath    %></p>
        <p>FileNameWithoutExt :    <%= UploadForm("file").FileNameWithoutExt   %></p>
        <p>FileExtension :         <%= UploadForm("file").FileExtension        %></p>
    </div>		
</body>
</html>

<%
    Set UploadForm = Nothing
%>
