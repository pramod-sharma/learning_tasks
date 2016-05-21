$(document).ready(function(){
  $('#searchQuery').click(function(){
    var enteredQuery = $('#query').val().split('(');
    var queryType = enteredQuery[0];
    var queryData = enteredQuery[1];
    var updateSelector = enteredQuery[2];
    queryData = queryData.replace(/(\)){1}$/,"");
    if (queryType === 'insert into ') {
      var query = queryData.split(',');
      var newElementID = $('.enteredInput').length;
      var newDiv = $('<div/>').addClass('enteredInput').appendTo($('#inputTable'));
      $('<div/>').text(newElementID).addClass('id inputEntered').appendTo(newDiv);
      $('<div/>').text(query[0]).addClass('name inputEntered').appendTo(newDiv);
      $('<div/>').text(query[1]).addClass('email inputEntered').appendTo(newDiv);
    }
    if(queryType === "select where ") {
      $('#resultOutput').empty();
      var selector = queryData.split('=');
      var selectorType = selector[0].trim();
      var selectorData = selector[1].trim();
      if(selectorType === 'id') {
        $('.enteredInput .id').filter(function(){
          return $(this).text()=== selectorData;
        }).parent('div').clone().removeClass().appendTo('#resultOutput');
      }
      if(selectorType === 'name') {
        $('.enteredInput .name').filter(function(){
          return $(this).text()=== selectorData;
        }).parent('div').clone().removeClass().appendTo('#resultOutput');
      }
      if(selectorType === 'email') {
        $('.enteredInput .email').filter(function(){
          return $(this).text()=== selectorData;
        }).parent('div').clone().removeClass().appendTo('#resultOutput');
      }
    }

    if(queryType === 'update') {
      queryData = queryData.replace(/(where){1}$/,"");
      queryData = queryData.trim();
      queryData = queryData.split('=');
      var updateType = queryData[0].trim();
      var updateData = queryData[1];
      updateData= updateData.replace(/(\)){1}$/,"");
      updateData = updateData.trim();
      selector = updateSelector.split('=');
      selectorType = selector[0].trim();
      selectorData = selector[1].trim();
      selectorData = selectorData.replace(/(\)){1}$/,"");
      if(selectorType === 'id') {
      $('.enteredInput .id').filter(function(){
          return $(this).text()=== selectorData;
        }).parent('div').find("."+updateType).text(updateData);
      }
      if(selectorType === 'name') {
        $('.enteredInput .name').filter(function(){
          return $(this).text()=== selectorData;
        }).parent('div').find("."+updateType).text(updateData);
      }
      if(selectorType === 'email') {
        $('.enteredInput .email').filter(function(){
          return $(this).text()=== selectorData;
        }).parent('div').find("."+updateType).text(updateData);
      } 
    }
  });
});