$(document).ready(function() {
  var $this;

  function crossImageMouseEnter(){
    $this = $(this);
    var offset = $this.position();
    var newImage = $('<img></img>').attr('src','icons/cross.jpg').css({
      top : offset.top,
      left : offset.left-20,
    }).addClass('crossIcon').prependTo($this);
    newImage.show();
  }


  function crossImageMouseLeave(){
    $this.find('img.crossIcon').remove();
  }


  function crossImageClick(){
     $this = $(this);
    var name = $this.parent().attr('class');
    var parentDivClass = $this.closest('div').attr('class').split(' ')[1];
    if(confirm("Do you really want to delete " + name + " from this list")){
      $('#roleDiv .' + parentDivClass + ' .'+ name).remove();
      $('#toDosDiv .'+ parentDivClass + ' .'+name).remove();
      if(!$('#toDosDiv .'+ parentDivClass + ' div').length) {
        $('#toDosDiv .'+ parentDivClass + ' img').attr('src','icons/minus.jpg');;
      }
    }
  }

  /* Expand Collapse button implementation*/
  $('#toDosDiv .collapseExpandButton').click(function(){
    $this = $(this);
    $this.siblings().toggle();
    if($this.siblings().length) {
      if ($this.attr('src') === 'icons/minus.jpg') {
        $this.attr('src','icons/plus.jpg');
      } else {
        $this.attr('src','icons/minus.jpg');
      }
    }
  });

  /*Draggable and Droppable implementation*/
  $('#employeesDiv li').draggable({  
    start : function(){
      $('#roleDiv li').unbind('mouseenter');
    },
    stop : function(){
      $('#roleDiv li').bind('mouseenter');
    },
      revert : 'valid',
      helper : 'clone',
      cursor : 'move',
      opacity : 0.5
  });

  $('#roleDiv div').droppable({
    drop : function(event,ui) {
      $this = $(this);
      var name = ui.draggable.text();
      var object = $this.find('.'+name);
      if(!object.length) {
        var newLiElement = ui.draggable.clone().removeClass().addClass(name).appendTo($this);
        var className = $this.attr('class').split(' ')[1];
        var targetDiv = $('#toDosDiv div.' + className );
        var newDiv = $('<div></div>').attr('class',name).appendTo(targetDiv);
        var newTodDoListElement = ui.draggable.clone().removeClass().addClass('toDoList').appendTo(newDiv);

        var newtaskDiv = $('<div><span>Enter task for ' + name + ' here<span></div>').addClass('taskDiv').appendTo(newDiv);
        $('<img></img>').attr('src','icons/plus.jpg').addClass('addTaskButton').appendTo(newtaskDiv)
        $('<div></div>').addClass('clearFloatDiv').appendTo(newDiv);
      }
    }
  });
    
/* Display cross image button to left of leftBox */
  $('#roleDiv li').live({
    mouseenter : crossImageMouseEnter,
    mouseleave : crossImageMouseLeave
  });

/*Attach click event to cross image*/
  $('#roleDiv img.crossIcon').live('click',crossImageClick);

/*Attach click to image in employees div section*/
  $('#employeesDiv img.crossIcon').live('click',function(){
    var name = $(this).parent('li').text();
    $(this).parent('li').remove();
    $('#roleDiv li.'+name).each(function(){
      var contextChangedFunction = $.proxy(crossImageMouseEnter,$(this));
      contextChangedFunction();
      contextChangedFunction = $.proxy(crossImageClick,$('#roleDiv img.crossIcon'));
      contextChangedFunction();
    });
  });
});