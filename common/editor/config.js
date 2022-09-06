/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	//config.height = dynamicEditorHeight();
	//config.skin = 'moono';
	config.docType = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">';
	config.font_defaultLabel = '굴림';
	config.font_names = '굴림/Gulim;돋움/Dotum;바탕/Batang;궁서/Gungsuh;Arial/Arial;Comic Sans MS/Comic Sans MS;Courier New/Courier New;Georgia/Georgia;Lucida Sans Unicode/Lucida Sans Unicode;Tahoma/Tahoma;Times New Roman/Times New Roman;Trebuchet MS/Trebuchet MS;Verdana/Verdana';
	config.fontSize_defaultLabel = '11';
	config.fontSize_sizes = '8/8px;9/9px;10/10px;11/11px;12/12px;14/14px;16/16px;18/18px;20/20px;22/22px;24/24px;26/26px;28/28px;36/36px;48/48px;';
	//config.language = "ko";
	config.resize_enabled = false;
	config.autoGrow_onStartup = true;
	config.autoGrow_maxHeight = 768;
	config.enterMode = CKEDITOR.ENTER_BR;
	config.shiftEnterMode = CKEDITOR.ENTER_P;
	config.startupFocus = true;
	config.toolbarCanCollapse = false;
	config.menu_subMenuDelay = 0;	
	config.toolbar = [
		[ 'Font', 'FontSize' ],
		[ 'TextColor', 'BGColor', '-', 'Bold', 'Italic', 'Underline', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ],
		[ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent' ],
		[ 'Link', 'Unlink' ], 
		[ 'Preview', 'Print', '-', 'Source'],
		'/',
		[ 'Styles', 'Format'],
		[ 'Image', 'Flash', 'Table', 'Smiley', 'SpecialChar', '-', 'youtube', 'oembed'],
		[ 'About' ]
	];
	// Make dialogs simpler.
	config.removeDialogTabs = 'image:advanced;link:advanced;Flash:advanced';	

	config.filebrowserUploadUrl = '/common/editor/upload.asp?type=Files';
	config.filebrowserImageUploadUrl = '/common/editor/upload.asp?type=Images';
	config.filebrowserFlashUploadUrl = '/common/editor/upload.asp?type=Flash';
};
