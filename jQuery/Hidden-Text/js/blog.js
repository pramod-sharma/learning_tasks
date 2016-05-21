$(document).ready(function() {
  $('#blog h3').click( function(event) {
    event.preventDefault();
    $(this).siblings('p.excerpt').slideDown('fast');
    $(this).parent().siblings().find('p.excerpt:visible').slideUp('slow');
  });
});