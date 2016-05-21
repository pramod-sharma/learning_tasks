$(document).ready( function() {
  $('#blog h3').each(function() {
    var newDiv = $('<div></div>').insertAfter($(this));
    $.data(newDiv,'reference',$(this));
  });
  $('#blog h3').each(function() {
    $(this).click(function(event) {
      event.preventDefault();
      var hrefAttribute = $(this).children('a').attr('href');
      var tempid = hrefAttribute.split('#');
      var id = 'data/blog.html '+'#'+tempid[1];
      $(this).next().load(id);
    });
  });
});
