var index = [];
$(document).ready(function () {
  $('ul:first').dcAccordion();
  $('li:not(:has(ul))').click(function(event){
    index = [];
    event.stopPropagation();
    $(this).parents('.dcjq-parent-li').each(function(){
      var $this = $(this);
      index.push($('li').index($this));
    });
    $this = $(this);
    index.push($('li').index($this));
    var urlString = index.join(',');
    var url = $this.find('a').attr('href');
    $this.find('a').attr('href',url+'?'+urlString);
  });
  var splittedUrl = [];
  var currentUrl = $(location).attr('href');
  splittedUrl = currentUrl.split('?');
  index = splittedUrl[1].split(',');
  var lastindex = index.pop();
    for (var i in index){
      $('li').eq(index[i]).children('ul').show();
    }
  $('li').eq(lastindex).addClass('highlight');  
});