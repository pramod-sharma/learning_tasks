$(document).ready(function(){
  var cache = {};
  var preSelectedIndexes = jQuery.makeArray($(':checked'));
  $('.burrito,.burritoBowl,.tacos,.salad,.smallQuesaddila,.singleTaco,.twoTaco').hide();
  
  $.ajax({ 
    dataType : "json",
    url : 'data.json',
    async : false,
    success: function(data) {
      cache = data;
    } 
  });

  /* Buttons related handler */
  function toggleMenu_Childmenu() {
    $(this).off('click');
    $(this).siblings().on('click',toggleMenu_Childmenu);
    $('.data').remove();
    $('#menuItemDisplay input:radio').prop('checked',false);
    $('.burrito,.burritoBowl,.tacos,.salad,.smallQuesaddila,.singleTaco,.twoTaco').hide();
    $('#summationRow').find('td:not(:eq(0))').text(0);
    $('#menu,#kidsMenu').toggle();
  }
  $('#kidsMenuButton').on('click',toggleMenu_Childmenu);


  var $this,recentlyAddedRow;



  function updateTable($this){
    var elementValueAttr = $this.val();
    if(elementValueAttr !== 'nomeat') {
      var newJSONObject = cache[elementValueAttr];
      var countVariable = 0;
      recentlyAddedRow = $('#summationRow').clone().removeAttr('id').attr('id',elementValueAttr).appendTo($('#nutrition tbody'));
      recentlyAddedRow.find('td').each(function(){
        $(this).html(newJSONObject[$('#nutrition th:eq('+countVariable+')').attr('class')]);
        countVariable++;
      });
      recentlyAddedRow.addClass('data');
      if($this.is($('input:radio'))) {
        recentlyAddedRow.addClass($this.attr('name')); 
      }
      var itemColumn = recentlyAddedRow.find('td:eq(0)');
      if($this.attr('name')==='adultmeat'|| $this.is('input:checkbox')) {
        recentlyAddedRow.addClass('clickableRow');
        if($this.attr('name')==='adultmeat') {
          $this.attr('class','adultmeat');
          $("<input type='text' value='1' size='1' class='textBox'>").appendTo(itemColumn);
          $("<input type='button' class='increment' value='+'>").appendTo(itemColumn);
          $("<input type='button' class='decrement' value='-'>").appendTo(itemColumn);
        }
      }
    }
  }
  /* main menu checkBoxes Handler*/
  $('#menuItemDisplay input:radio').on('change',function(){
    var $this = $(this);
    $('.burrito,.burritoBowl,.tacos,.salad,.smallQuesaddila,.singleTaco,.twoTaco').hide();
    $('.data').remove();
    $('#summationRow').find('td:not(:eq(0))').text(0);
    var className = $this.val();
    $(':checked').prop('checked',false);
    $this.prop('checked',true);
    $('#subMenus').show();  
    $('.'+className).show();
    $.each(preSelectedIndexes,function(index,value){
      $(value).prop('checked',true);
      if ($(value).is($(':visible'))){
        $(value).change();
        updateTotalNutrition();
      }
    });
  });

  $('#subMenus input:radio').on('change',function(){
    $this = $(this);
    if($this.is($('input:radio[name="meat"]'))) {
      if ($this.is($('input:radio[value="nomeat"]'))) {
        $('#nutrition tbody .'+$this.attr('name')).remove();
      } else {
        updateTable($this);
        $('input:checkbox:checked').each(function(){
          $this =$(this);
          $('#nutrition tbody #'+$this.attr('value')).click();
        });
      }
    } else {
      $('#nutrition tbody .'+$this.attr('name')).remove();
      updateTable($this);
    }
    updateTotalNutrition();
  });

  /* CheckBox Click Handler*/
  $('#subMenus input:checkbox').on('change',function(){
    $this = $(this);
    if($this.closest('td').hasClass('WhatsInside')){
      if(($('#nomeat:checked').length )&&($('.WhatsInside :checked').length > 3)){
        $this.prop('checked',false);
        return true;
      } else if(!($('#nomeat:checked').length )&&$('.WhatsInside :checked').length > 2) {
        $this.prop('checked',false);
        return true;
      }
    }
    if($this.is($(':checked'))) {
      updateTable($this);
    } else {
      $('#'+$this.val()).remove();
    }
    updateTotalNutrition();
  });
  
/*Summation of Nutrition of each category and diplay result*/
  function updateTotalNutrition(){
    var countVariable=1,nutritionSum=0;
    $('#summationRow td:not(:eq(0))').each(function(){
      nutritionSum = 0;
      $('.data').each(function(){
        nutritionSum = nutritionSum + parseInt($(this).find('td:eq('+countVariable+')').text());
      });
      $(this).text(nutritionSum);
      countVariable++;
    });
  }

/*Meat Servings Count Handler +,-and textbox handler*/
var recentCount,prevCount;
  function updateMeatServings(target) {
    $(target).siblings('input:text').val(recentCount);
    $(target).parent().siblings().each(function(){
      var currentValue=parseInt($(this).text());
      $(this).text(currentValue*recentCount/prevCount);
    });
  }
  $('#nutrition').on('click','.increment',function(event){
    event.stopPropagation();
    prevCount = parseInt($(this).siblings('input:text').val());
    if (prevCount === 1){
      recentCount = prevCount+1;
      updateMeatServings(event.target);
      updateTotalNutrition();
    }
  });
  $('#nutrition').on('click','.decrement',function(event){
    event.stopPropagation();
    prevCount = parseInt($(this).siblings('input:text').val());
    if (prevCount === 2) {
      recentCount = prevCount-1;
      updateMeatServings(event.target);
      updateTotalNutrition();
    }
  });
  
  $('#nutrition').on('focus click','.textBox',function(event){
    event.stopPropagation();
    prevCount = parseInt($(this).val());
  });

  $('#nutrition').on('blur','.textBox',function(event){
    event.stopPropagation();
    var target = event.target;
    recentCount = parseInt($(target).val());
    if((recentCount===1)||(recentCount===2)){
      $(target).parent().siblings().each(function(){
        var currentValue=parseInt($(this).text());
        $(this).text(currentValue*recentCount/prevCount);
      });
      updateTotalNutrition();
    } else {
      $(target).val(prevCount);
    }
  });

  /* Clickable Row of Nutrition table*/
  $('#nutrition').on('click','.clickableRow',function(){
    var value = $(this).attr('id');
    $(this).remove();
    $('#subMenus input:checkbox[value="'+value+'"]').prop('checked',false);
    updateTotalNutrition(); 
  });
});