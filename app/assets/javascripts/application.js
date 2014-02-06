// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require bootstrap
//= require turbolinks
//= require_tree .

function openPopup(link)
{
//   link.hide();
    window.open("newDebate",'newDebate','toolbar=no,location=no,menubar=no,scrollbars=yes,resizable=no');
    return false;
}

function popupDebate()
{
	link.hide();
	window.open(this.href,'newDebate', 'height=600, width=600');
	return false;
}

$(function()
{
	$('.modal-opener').on('click', function()
	{
		window.open(this.href,'newDebate', 'height=600, width=600');
		return false;
	});
	
	$('.modal-closer').on('click', function()
	{
		$('#sky-form-modal-overlay').fadeOut();
		$('.sky-form-modal').fadeOut();
		
		return false;
	});
});


