// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function() {
 $('#menu li').on('click', function(){
    if($(this).not('selected')){
      // タブメニュー
      $(this).addClass('selected').siblings('li').removeClass('selected');
      // タブの中身
      var index = $('#menu li').index(this);
      $('#tab div').eq(index).addClass('selected').siblings('div').removeClass('selected');
    }
  });
})

//
// $(function(){
//   $('#tab-menu li').on('click', function(){
//     if($(this).not('selected')){
//       // タブメニュー
//       $(this).addClass('selected').siblings('li').removeClass('selected');
//       // タブの中身
//       var index = $('#tab-menu li').index(this);
//       $('#tab-box div').eq(index).addClass('selected').siblings('div').removeClass('selected');
//     }
//   });
// });
