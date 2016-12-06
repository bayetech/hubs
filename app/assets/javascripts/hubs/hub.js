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
//= require jquery3
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function hub_avatar_img_error(image) {
    image.onerror = "";
    image.src = "https://baye-media.oss-cn-shanghai.aliyuncs.com/default_head.png";
    return true;
}

function adaptFun(designPercent){
  var mainWidth = document.body.clientWidth;
  var fontSize = mainWidth/designPercent + 'px';
  document.documentElement.style.fontSize = fontSize;
  //视窗变化时需要再次适配，这种情况实际价值不是很大！最主要的只是首次适配
  window.onresize = function(){
      var mainWidth = document.body.clientWidth;
      var fontSize = mainWidth/designPercent + 'px';
      document.documentElement.style.fontSize = fontSize;
  }
}

$(document).on('turbolinks:load', function() {
  $('#reply-input').on('focus',function(event){
    $('.hub-kong').remove();
    $('.topic-footer-bar').parent().append("<div class='hub-kong-end'></div>");
  });
})

$(document).ready(function() {
  adaptFun(750/50);
});
