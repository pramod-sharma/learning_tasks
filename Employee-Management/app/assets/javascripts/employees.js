// FIXME_AB: we should write Object oriented JS

$(document).ready( employeePageSetup );
$(document).on("page:load", employeePageSetup );

function employeePageSetup(){
  //For employee list sorting 
  // $(document).on('click', '#involvement-column', sortEmployees);
  
  // For Tabs Setup
  employeeTabsSetup();

  // For Employee Involvement Date handler
  employeeListingHandler();

  // Display modal when relieve button is clicked
  $(document).on( 'click', '.relieve_employee_button', display_relieve_modal);

  // Handles relieve button in modal
  $(document).on( 'click', '#relieve_employee_modal .relieve-employee-button', relieveButtonHandler );
  
  // On clicking save button
  $('#current-assignment').on( 'click', '.save_button', updateProjectAssignments );

  $('#employeesList').tablesorter({
    headers: {
      0: { sorter: false },
      1: { sorter: false },
      2: { sorter: false },
      3: { sorter: false },
      5: { sorter: false }
    }
  });
  $('.toggle-employees-list').on('click', toggleActiveInactiveEmployees);
}

function toggleActiveInactiveEmployees(){
  $('#employeesList tbody tr').toggle();
  $(this).text(function(index, text){
    return text == 'Show Active Employees' ? 'Show Inactive Employees' : 'Show Active Employees'
  })
}

function employeeTabsSetup(){
  $( "#tabs" ).tab();
  $('#employeeListing').addClass('active');
  $('#current-assignment').addClass('active');
}


function employeeListingHandler(){
  $(".involvement_date").datepicker({
    dateFormat: "dd M yy",
    onSelect: function( date_picked ){
      $('.progress-bar').show();
      var params = {};
      var ajax_url = $(this).data('url');
      params['involvement_date'] = date_picked;
      $.ajax({
        url: ajax_url,
        type: "GET",
        dataType: "script",
        data: params,
        complete: function( jqXHR ){
          setTimeout(function(){
            $('.progress-bar').hide();
          }, 1500 );
          $('#employeesList').tablesorter({
            headers: {
              0: { sorter: false },
              1: { sorter: false },
              2: { sorter: false },
              3: { sorter: false },
              5: { sorter: false }
            }
          });
        }
      });
    }
  });
}