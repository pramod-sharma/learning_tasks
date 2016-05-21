//Handler for delete project button in case of success
$(document).on('ajax:success',  "a[data-remote].delete-project", function(event){
  $(event.target).closest('tr').remove();
  alert("Project is successfully deleted");
});

$(document).on('ajax:error',  "a[data-remote].delete-project", function(){
  alert("Project is not able to be deleted");
});

$(document).ready( projectPageSetup);
$(document).on("page:load", projectPageSetup);

function projectPageSetup(){
  // Sets tab for projects
  projectTabsSetup();
  var month = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  // To be uncommented when used on view basis
  // $('#current-assignment').on( 'click', '.save_button', updateProjectAssignments );

  // Binds params to remote request
  // $('#monthlyBilling').on('ajax:before', '.save_button', updateMonthlyBilling );

  // Display modal when button is clicked
  $(document).on( 'click', '.relieve_employee_button', display_relieve_modal);

  // To be uncommented when used on view basis Relieve employee button handler
  // $(document).on( 'click', '#relieve_employee_modal .relieve-employee-button', relieveButtonHandler );
}

function updateMonthlyBilling(row){
  var amount = row.find('.amount input:text').val();
  var params = { 'amount' : amount, '_method' : 'patch'}
  var ajax_url = row.find('.save_button').data('url');
  $.ajax({
    url: ajax_url,
    type: "POST",
    dataType: "Script",
    data: params
  });
}

function checkForEnterKey(event){
  if(event.which == 13){
    console.log($(this));
    var parent_row = $(this).closest('tr');
    updateMonthlyBilling(parent_row);
  }
}

function projectTabsSetup(){
  $( "#tabs" ).tab();
  $('#running_projects').addClass('active');
  $('#current-assignment').addClass('active');
  $('.save_button').hide();
  $('.cancel_button').hide();
  $('#monthlyBilling').on('click', '.save_button', function(event){
    event.preventDefault();
    var parent_row = $(this).closest('tr');
    updateMonthlyBilling(parent_row);
  });
  $('#monthlyBilling').on('keyup', '#amount', checkForEnterKey);//For enter button click to be handled in different way after review
}
