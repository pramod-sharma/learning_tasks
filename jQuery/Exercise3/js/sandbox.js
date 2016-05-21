$(document).ready(function() {
    for (i=0;i<5;i++) {
        $('#myList').append('<li>new</li>');   
    }
    $('ul li:even').remove();
    $('div.module:last').append('<h2>New Heading</h2><p>New Para</p>');
    var $newOption = $('<option>Wednesday</option>');
    $newOption.val('Wednesday');
    $('select').append($newOption);
    $('img:first').clone().appendTo($('<div></div>').attr('class','module').insertAfter('div.module:last')); 
});