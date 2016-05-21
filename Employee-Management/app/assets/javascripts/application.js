
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require jquery.ui.autocomplete
//= require twitter/bootstrap
//= require_tree .

// FIXME_AB: Don't dump all the JS in one single file. Create different JS files for different pages. And then include them on the required pages.

$(document).ready( mainPageSetup )
$(document).on("page:load", mainPageSetup );

function mainPageSetup(){
  dateFieldHandler();
   $(".search-query").autocomplete({
    source: gon.auto_complete_options,
    select: function( event, ui ) { 
      window.location.href = ui.item.url;
    }
  });
  $('#new_project_assignment').on('ajax:before',function(){
    $('.progress_bar').show();
  });
}

function dateFieldHandler(){
  $(".date-field").datepicker({
    dateFormat: "dd M yy",
  });
}

function updateRecord(){
  $.ajax({
    url: ajax_url,
    type: "POST",
    dataType: "script",
    data: params
  });
}



// Display the relieving modal for project assignments
function display_relieve_modal( event ){
	event.preventDefault();
  var parent_row =  $(this).closest('tr');
  var joining_date = parent_row.children('.joining-date').text();
  var relieving_date = parent_row.children('.relieving-date').text();

  var url = $(this).data('url');
  var involvement_cell = parent_row.children('.involvement');
  var involvement = involvement_cell.text().replace(/[\%]/g, '');
  $('#relieve_employee_modal .modal-body #relieving_date').val(relieving_date);
  $('#relieve_employee_modal .modal-body #involvement').val(involvement);
  $('#relieve_employee_modal .relieve-employee-button').data('url', url);
  $('#myModalLabel').text('Relieving date must be after ' + joining_date);
  $('#relieve_employee_modal').modal('show');
}

// Handles the click button event on modal's relieve button
function relieveButtonHandler( event ){
	event.preventDefault();
  var ajax_url = $(this).data('url');
  var params = {};
  params['relieving_date'] = $('#relieve_employee_modal .modal-body #relieving_date').val();
  params['involvement'] = parseInt( $('#relieve_employee_modal .modal-body #involvement').val() );
  $.ajax({
    url: ajax_url,
    type: "POST",
    dataType: "script",
    data: params
  });
}

// Used in both employee and project for project assignment updateProjectAssignments
function updateProjectAssignments( event ){
  event.preventDefault();
  var joining_date = $(this).closest('tr').find('.joining-date input:text').val();
  var relieving_date = $(this).closest('tr').find('.relieving-date input:text').val();
  var involvement = $(this).closest('tr').find('.involvement input:text').val();
  var params = {};
  params['joining_date'] = joining_date;
  params['relieving_date'] = relieving_date;
  params['involvement'] = involvement;
  params['_method'] = 'patch';
  var ajax_url = $(this).data('url');
  $.ajax({
    url: ajax_url,
    type: "POST",
    dataType: "script",
    data: params
  });
}