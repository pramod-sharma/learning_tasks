$(document).ready(function() {
  $('div.module').css("display","none");
  var $newElement = $('<ul></ul>').insertBefore('div.module:first');
  $newElement.attr("id","newtabs");
  $('div.module').each(function() {
    var $headingElement = $(this).find('h2');
    var $listItem = $('<li></li>').append($headingElement).append($(this));
    $listItem.appendTo($newElement);
  });
  $('#newtabs > li').click(function() {
      $(this).children('div.module').css("display","block").addClass('current');
      $(this).siblings().children('div.module').css("display","none").removeClass('current');
    });
  $('#newtabs > li:first-child').children('div.module').css("display","block");
});