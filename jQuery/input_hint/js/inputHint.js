$(document).ready( function() {
  var $labelObj = $("label[for='q']");
  $('input.input_text').attr('value',$labelObj.text());
  $('input.input_text').addClass("hint");
  $labelObj.remove();
  function normalFocusHandler(){
    if ($(this).val() === $labelObj.text()) {
      $(this).attr('value','').removeClass('hint');
    } else { 
      $(this).removeClass('hint');
    }
  }
  function editedFocusHandler() {
      $(this).removeClass('hint');
  }
  $('input.input_text').bind('focus',normalFocusHandler);
  $('input.input_text').bind('blur',function () {
    if($(this).val() === '') {
      $(this).attr('value',$labelObj.text()).addClass('hint');
      $(this).bind('focus',normalFocusHandler);
      $(this).unbind('focus',editedFocusHandler);
    } else {
      $(this).addClass('hint');
      $(this).unbind('focus',normalFocusHandler);
      $(this).bind('focus',editedFocusHandler);
    }
  });
  $('input.input_text').change(function(){
    $('input.input_text').bind('focus',editedFocusHandler);
  });
});
