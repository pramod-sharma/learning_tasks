$(document).ready( function() {
  $('body').prepend($('#slideshow'));
  var $divElement = $('<div></div>').insertAfter($('#slideshow'));
  $('#slideshow li').hide();
  var $length = $('#slideshow li').length;
  var i;  
  function slideShow(i) {
    var element = $('#slideshow li:eq('+ i +')');
    element.fadeIn(200, function() {
      $divElement.html('You are viewing ' + (i+1) + " out of " + $length + " items");
    }).delay(2000).fadeOut(200,function() {
      $divElement.empty();
      i++;
      if(i === $length){
        slideShow(0);      
      } else {
        slideShow(i);
      }
    });
  }
  slideShow(0);
});