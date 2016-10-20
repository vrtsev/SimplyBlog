// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require angular
//= require turbolinks
//= require_tree .

var layout = angular.module("layoutApp", []);
layout.controller("layoutCtrl", function ($scope) {
	$scope.peremennaya = "OLOLO";
});


switcher = false

$(document).on('turbolinks:load', function() {


	if (switcher === true) {
		$('#sidebar').hide();
		$('#sidebar_row').attr("class", "col-md-1");
		$('#content_row').attr("class", "col-md-9");
	};

	$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})

	$(function () {
	  $('[data-toggle="popover"]').popover()
	})

	$('#myModal').on('shown.bs.modal', function () {
	  $('#myInput').focus()
	})

	$('#post_create').on('shown.bs.modal', function () {
	  $('#myInput').focus()
	})

	$('#sidebar-btn').click(function(){


		var hide = $('#sidebar').attr('display', 'none');
		var show = $('#sidebar').slideToggle();
		
		if ($('#sidebar_row').hasClass('col-md-3') ) {
			hide
			$('#sidebar_row').attr("class", "col-md-1");
			$('#content_row').attr("class", "col-md-9");
			switcher = true
			console.log(switcher)
		} else {
			$('#sidebar_row').attr("class", "col-md-3");
			$('#content_row').attr("class", "col-md-7");
			show
			switcher = false
			console.log(switcher)
		};


	})

})