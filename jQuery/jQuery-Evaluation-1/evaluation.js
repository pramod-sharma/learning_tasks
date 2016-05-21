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
      $('<div/>').text(newElementID).addClass('idDiv inputEntered').appendTo(newDiv);
      $('<div/>').text(query[0]).addClass('nameDiv inputEntered').appendTo(newDiv);
      $('<div/>').text(query[1]).addClass('emailDiv inputEntered').appendTo(newDiv);
    }
    if(queryType === "select where ") {
      $('#resultOutput').empty();
      var selector = queryData.split('=');
      var selectorType = selector[0].trim();
      var selectorData = selector[1].trim();
      if(selectorType === 'id') {
        $('.enteredInput .idDiv').filter(function(){
          return $(this).text()=== selectorData;
        }).parent('div').clone().removeClass().appendTo('#resultOutput');
      }
      if(selectorType === 'name') {
        $('.enteredInput .nameDiv').filter(function(){
          return $(this).text()=== selectorData;
        }).parent('div').clone().removeClass().appendTo('#resultOutput');
      }
      if(selectorType === 'email') {
        $('.enteredInput .emailDiv').filter(function(){
          return $(this).text()=== selectorData;
        }).parent('div').clone().removeClass().appendTo('#resultOutput');
      }
    }

    if(queryType === 'update') {
      queryData = queryData.replace(/(where){1}$/,"");
      queryData = queryData.trim();
      queryData = queryData.split('=');
      var updateType = queryData[0].trim();
      var updateData = queryData[1].trim();
      selector = updateSelector.split('=');
      selectorType = selector[0].trim();
      selectorData = selector[1].trim();
      var className = "."+updateType+"Div";
      console.log(className);
      if(selectorType === 'id') {
        console.log('in');
        $('.enteredInput .idDiv').filter(function(){
          return $(this).text()=== selectorData;
        }).parent('div').find().;
      }
      if(selectorType === 'name') {
        console.log('in');
        $('.enteredInput .nameDiv').filter(function(){
          return $(this).text()=== selectorData;
        }).parent('div')
      }
      if(selectorType === 'email') {
        console.log('in');
        $('.enteredInput .emailDiv').filter(function(){
          return $(this).text()=== selectorData;
        }).parent('div').find('.'+updateType+'Div').text(updateData);
      } 
    }
  });
});