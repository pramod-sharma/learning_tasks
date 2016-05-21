$(document).ready(function(){
  var $this;
  $('#toDosDiv img.addTaskButton').live('click',function(){
    $this = $(this);
    if($this.parent().children('div').length === 0) {
      $this.parent().children('span').remove();
    }
    var newDiv = $('<div></div>').addClass('toDoTaskDiv');
    $('<input type="text" value="Add a new todo here" size="20"></input>').addClass('inputTextBox').appendTo(newDiv);
    $('<img src="icons/save.jpg"></img>').addClass('saveButton').appendTo(newDiv);
    $('<img src="icons/cross.jpg"></img>').addClass('deleteButton').appendTo(newDiv);
    newDiv.appendTo($this.parent());
    if($this.parent().children('div').length > 3) {
      $this.parent().addClass('overflowTaskDiv');
    } else {
      $this.parent().removeClass('overflowTaskDiv');
    }
  });  
  $('#toDosDiv img.saveButton').live('click',function(){
    $this = $(this);
    var toDoText = $this.siblings('input').attr('value');
    $('<div>'+toDoText+'</div>').addClass('inputDivBox').replaceAll($this.siblings('input'));
    $('<img src="icons/edit.jpg"></img>').addClass('editButton').replaceAll($this);
  });

  $('#toDosDiv img.deleteButton').live('click',function(){
    $this = $(this);
    if(!$this.parent().siblings('div,input').length) {
      var taskDivElement = $this.parents('.taskDiv');
      var name = taskDivElement.parent().attr('class');
      $this.parents('.taskDiv').prepend($('<span>Enter task for '+ name  +' here</span>'))
    }
    $this.parent().remove();
  });

  $('#toDosDiv img.editButton').live('click',function(){
    var divBoxElement = $(this).siblings('div');
    $('<input type="text" value="' + divBoxElement.text()+'" size="20"></input>').addClass('inputTextBox').replaceAll(divBoxElement);
    $('<img src="icons/save.jpg"></img>').addClass('saveButton').replaceAll($(this));
  });

  $('#toDosDiv>img').live('click',function(){
    if($(this).attr('class') === 'expandAllButton') {
      $('#toDosDiv div').slideDown();
    } else {
      $('#toDosDiv div').slideUp();
    }
  });

  $('button.search').click(function(){
    var searchItem = $('#searchToDos').val();
    if(searchItem === '') {
      $('#roleDiv div li').slideDown();
    } else {
        $('#roleDiv div').each(function(){
          $this = $(this);
          if($this.find('.'+searchItem).length) {
            $this.find('.'+searchItem).animate({ backgroundColor: "#CFCFCF"}, 1500).animate({backgroundColor: "FFFFFF"},1500);
          } else {
            $this.children('li').slideUp();
        }
      });
    }
  });

  $('#employeesDiv li').live({
    mouseenter : function() {
    $this = $(this);
    var offset = $('#toDosDiv').position();
    var topOffset = $this.position();
    var newImage = $('<img></img>').attr('src','icons/cross.jpg').css({
        top : topOffset.top,
        left : offset.left-1,
      }).addClass('crossIcon').prependTo($this);
      newImage.show();
    },
    mouseleave : function(){
      $this.find('img.crossIcon').remove(); 
    }
  });
});