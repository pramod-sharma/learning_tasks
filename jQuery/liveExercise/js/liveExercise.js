$(document).ready(function () {
  $('#addDivButton').live('click',function(){
    var divLength = $('div.testDiv').length + 1;
    if(divLength > 1) {
      $('<div></div>').addClass('testDiv').html(divLength).insertAfter($('div.testDiv:last'));
    } else {
      $('<div></div>').addClass('testDiv').html(divLength).insertAfter($('#addDivButton'));
    }
  });
  $('div.testDiv').live('click',function() {
    $(this).css("border","solid 2px blue");
    $(this).siblings().css('border','solid 1px black');
  });
  $('div.testDiv:last').live('click',function(event) {
    $(this).remove();
  });
});