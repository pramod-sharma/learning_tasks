$(document).ready( function() {
  $('#nav > li > ul').addClass('hover');
  $('#nav > li').hover( function() {
    $(this).find('ul').removeClass('hover');
  },
  function() {
    $(this).find('ul').addClass('hover');
  });
});