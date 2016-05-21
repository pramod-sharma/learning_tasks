/*
Format to insert row :- insert into(a,d);
format to select row :- select where(Id=2);
format to update row :- update(Name=x) where(Email=y);
*/
$(document).ready(function(){
  var JSON_Object = {"database" : []};
  var queryData,queryType,updateSelector,selectorType,selectedRowArray=[];
  function insertIntoJSON() {
    var query = queryData.split(',');
    var newElementID = $('.enteredInput').length;
    var newJSON_String = '{"Id" : "'+newElementID+'"'+',"Name" : "'+ query[0]+'"'+ ',"Email" : "'+query[1]+'"}';
    JSON_Object.database.push(JSON.parse(newJSON_String));
  }
  function displayJSON(){
    $('#inputTable .enteredInput').remove();
    $.each(JSON_Object.database,function(index,value){
      var newDiv = $('<div/>').addClass('enteredInput').appendTo($('#inputTable'));
      $('<div/>').text(value.Id).addClass('id inputEntered').appendTo(newDiv);
      $('<div/>').text(value.Name).addClass('name inputEntered').appendTo(newDiv);
      $('<div/>').text(value.Email).addClass('email inputEntered').appendTo(newDiv);
    });
  }

  function select_Row(){
    selectedRowArray = [];
    var selector = queryData.split('=');
    var selectorType = selector[0].trim();
    var selectorData = selector[1].trim();
    $.each(JSON_Object.database,function(index,value){
      if(value[selectorType]===selectorData) {
        selectedRowArray.push(value);
      }
    });
  }

  function display_Selected_Row() {
    $('#resultOutput').empty();
    $.each(selectedRowArray,function(index,data){
      var newDiv = $('<div/>').appendTo($('#resultOutput'));
      $('<div/>').text(data.Id).addClass('id inputEntered').appendTo(newDiv);
      $('<div/>').text(data.Name).addClass('name inputEntered').appendTo(newDiv);
      $('<div/>').text(data.Email).addClass('email inputEntered').appendTo(newDiv);
    });
  }

  function updateJSON() {
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
      $.each(JSON_Object.database,function(index,value){
        if(value[selectorType] === selectorData) {
          value[updateType] = updateData;
        }
      });
  }

  $('#searchQuery').click(function(){
    var enteredQuery = $('#query').val().split('(');
    queryType = enteredQuery[0];
    queryData = enteredQuery[1];
    updateSelector = enteredQuery[2];
    queryData = queryData.replace(/(\)){1}$/,"");
    if (queryType === 'insert into') {
      insertIntoJSON();
      displayJSON();
    }
    if(queryType === "select where") {
      select_Row();
      display_Selected_Row();
    }
    if(queryType === 'update') {
      updateJSON();
      displayJSON();
    }
  });
});