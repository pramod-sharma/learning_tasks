$(document).ready( function() {
  var cache = {};
  var $formElement = $('#specials form');
  var $newDiv = $('<div></div>').insertAfter($formElement);
  var $selectElement = $formElement.find('select[name="day"]');
  
  $selectElement.change(function() {
    $newDiv.empty();
    var $data = $(this).val();
    if ( $.isEmptyObject(cache) ){
      $.ajax({ 
        dataType : "json",
        url: 'data/specials.json',
        async : false,
        success: function(data) {
          cache = data;
          $formElement.find('li.buttons').remove();
        } 
      });
    }
    $('<h4></h4>').text(cache[$data].title).appendTo($newDiv);
    $('<p></p>').text(cache[$data].text).appendTo($newDiv);
    var imageSource = cache[$data].image.replace(/^\//,'');
    $('<img></img>').attr('src',imageSource).appendTo($newDiv);
    $newDiv.css('color',cache[$data].color);
  });
});