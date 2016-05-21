$(document).ready(function() {
  var $this;
  /* Expand Collapse button implementation*/
  $('#toDosDiv img').click(function(){
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
      var text = ui.draggable.text();
      var object = $this.find('.'+text);
      if(!object.length) {
        var newLiElement = ui.draggable.clone().removeClass().addClass(text).appendTo($this);
        var className = $this.attr('class').split(' ')[1];
        var targetDiv = $('#toDosDiv div.' + className );
        var newDiv = $('<div></div>').attr('class',text).appendTo(targetDiv);
        var newTodDoListElement = ui.draggable.clone().removeClass().addClass('toDoList').appendTo(newDiv);

        $('<div> Enter task for ' + text + ' here</div>').addClass('taskDiv').appendTo(newDiv);
        $('<div></div>').addClass('clearFloatDiv').appendTo(newDiv);
      }
    }
  });
    
/* Display cross image button to left of leftBox */
  $('#roleDiv li').live({
    mouseenter : function() {
    $this = $(this);
    var offset = $this.position();
    var newImage = $('<img></img>').attr('src','icons/cross.jpg').css({
        top : offset.top,
        left : offset.left-20,
      }).addClass('crossIcon').prependTo($this);
      newImage.show();
    },
    mouseleave : function(){
      $this.find('img.crossIcon').remove(); 
    }
  });

/*Attach click event to cross image*/
  $('img.crossIcon').live('click',function(){
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
  });
});