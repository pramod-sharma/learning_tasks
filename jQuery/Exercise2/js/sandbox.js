$(document).ready(function() {
    $('img').each(function(){
        console.log($(this).attr("alt"));
    });
    $('input.input_text').closest('form').addClass('mySearchBox');
    $('#myList li.current').removeClass('current').next().addClass('current');
    $('#specials').find('input');
    $('#slideshow li:first').addClass('current').siblings().addClass('disabled');
}); 