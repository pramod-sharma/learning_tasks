// Load the Visualization API and the piechart package.
google.load('visualization', '1.0', {'packages':['corechart']});
google.load('visualization', '1', {packages:['table']});

$availabilty_tab_refreshed = true;
$(document).ready( reportPageSetup );
document.addEventListener("page:load", reportPageSetup );

function reportPageSetup(){
  billingDateHandler();
  $("#tabular_report").on('click', tableAjaxHandler );
  $('#projection_start_date, #projection_end_date').datepicker({
    dateFormat: "dd M yy"
  });

  $("#revenue_date").datepicker({
    dateFormat: "dd M yy",
    changeMonth: true,
    changeYear: true,
    onSelect: revenueDetailsButtonHandler
  });

  $(document).on('ajax:before', '#availability_utilization', function(){
    $('#availability_utilization').siblings('.progress_bar').show();
  });

  $(document).on('ajax:success', '#availability_utilization', function(){
    var report_date = $('#from_date').val();
    $availabilty_tab_refreshed = false;
    $('#availability_utilization').siblings('.progress_bar').hide();
    utilizationPageHandler(report_date);
  });

  $('#revenue_details').on('click', detailsButtonHandler );
  $('.report_link').tooltip({
    html: true
  });
  utilizationHandler();
  reportTabsHandler();
  // buttonHandler();
  formatRows();
  lineChartHandler( );
  rootPieChartHandler();
  breadCrumHandler();
  $('#toggle').on('click', toggleAvailablilityDisplay);
  $(document).on('click', '#availability-column', sortReport);
  $('.report-help-button').on('click', slideDownHelp);
  $('a[data-toggle="tab"]').on('show', hideReportHelp);
  $('#relievingEmployeesTable').tablesorter({
    headers: {
      0: { sorter: false },
      1: { sorter: false },
      2: { sorter: false }
    }
  });

  $(document).on('click', '.ui-datepicker-close', monthlyDateHandler)
}

function monthlyDateHandler(){
  $( "#billing_date" ).datepicker( "hide" );
  var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
  var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
  utilizationPageHandler(new Date(year, month, 1));
}
  
function hideReportHelp(){
  $('.alert-info').hide();
}

function slideDownHelp(){
  $('.alert-info').slideToggle();
}

function sortReport(){
  report_date = $( "#utilization_date" ).val();
  utilizationTableHandler(report_date);
  if($('#toggle').prop('checked') == true){
    $('.fully-involved').toggle();
  }
}

function toggleAvailablilityDisplay(){
  $('.fully-involved').toggle();
}

function detailsButtonHandler(){
  window.location = $(this).data('url') + "?revenue_date=" + $('#billing_date').val() + "&filter_basis=project_based" ;
}

function billingDateHandler(){
  $('#billing_date').datepicker({
    changeMonth: true,
    changeYear: true,
    showButtonPanel: true,
    dateFormat: 'M yy',
    beforeShowDay: function(){ 
            return false
          }
  });
}

function breadCrumHandler(){
  $(document).on('click', '.breadcrumb li:not(.active)', function(){
    var params = {};
    params['id'] = $(this).data('id');
    params['key'] = $(this).data('key');
    params['utilization_date'] = $("#pie_report_date").val();
    $.ajax({
      url: "/report/pie_report",
      type: "GET",
      dataType: "Script",
      data: params
    }); 
  });
}

function revenueDetailsButtonHandler(date_selected){
  var element_clicked = $(this);  
  var params = {};
  params['filter_basis'] = $("input:radio:checked").val();
  params['revenue_date'] = date_selected;
  $('.revenue_progress_bar').show();
  revenueReport(params, element_clicked);
}

function reportTabsHandler(){
  $( "#tabs" ).tab();
  $('#pie_report_container').addClass('active');
}


function rootPieChartHandler() {
  if( typeof gon != 'undefined'){
    createPieChart(gon);
    $(".piechartspan").data("key", "team");
  }
}


function employeePieChartHandler(response){ 
  $(".breadcrumb").append('<span class="divider">></span><li class="active"><a href="#">Library</a></li>'); 
  createPieChart( response );
  $(".piechartspan").data("key", "emp");
}


function createPieChart(response){
  if (typeof( response.data ) != 'undefined' && response.data.length) {
    $("#charts_div").empty();
    for(i = 0; i < response.data.length; i++){
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Status');
      data.addColumn('number', 'Percentage');
      data.addRows(response.data[i]);

      var options = {
        width:450, 'height':250,
        colors:['#e0440e', 'green' ],
        tooltip: { text: 'percentage'},
        is3D: true,
      };
      var span = $("<span/>");
      span.addClass('span4 piechartspan').appendTo('#charts_div');
      var chart = new google.visualization.PieChart(span.get(0));
      chart.draw(data, options);
      span.data('id', response.ids[i]);
      span.prepend('<div class="details_link">' + response.links[i]  + '</div>')

      span.on('click', function(){
        cache = response;
        var element_clicked = $(this);
        var id = element_clicked.data('id');
        var key = element_clicked.data('key');
        var params = {};
        params['id'] = id;
        params['key'] = key;
        params['utilization_date'] = $("#pie_report_date").val();
        $.ajax({
          url: "/report/pie_report",
          type: "GET",
          dataType: "Script",
          data: params
        });  
      });
    }
  }
}


function lineChartHandler( ){
  if( typeof gon != 'undefined' && typeof gon.revenue_projections != 'undefined'){
    google.setOnLoadCallback( drawChart( gon.revenue_projections ) );
  }
}


function formatRows(){
  $('.availability').each(function(){
    var available = parseInt($(this).text());
    var row = new Row( $(this), available );
    row.format();
  });
  $('.total_involvement').each(function(){
    var available = 100 - parseInt( $(this).text() );
    var row = new Row( $(this), available );
    row.format();
  });
}

function Row( row, available ){
  this.availability = available;
  this.row = row;
  this.format = format;
}

function format(){
  if(this.availability <= 0)
    this.row.parent().addClass('fully-involved');
  else if( this.availability == 100)
    this.row.parent().addClass('fully-available');
  else
    this.row.parent().addClass('average-involved');
}


function drawChart( response ) {
  var data = new google.visualization.DataTable();
  data.addColumn({type: 'string', role: 'domain'});
  data.addColumn({type: 'number', role: 'data', label: 'Potential Revenue'});
  data.addColumn({type: 'string', role: 'annotation'});
  data.addColumn({type: 'number', role: 'data', label: 'Actual Revenue'});
  data.addColumn({type: 'string', role: 'annotation'});
  data.addRows(response);
  var options = {
    title: 'Revenue Projection',
    vAxis: { format: '$#' },
    chartArea: { width: "80%" }
  };
  var chart = new google.visualization.LineChart( document.getElementById('line_chart_div') );
  
  chart.draw( data, options );
}

function tableAjaxHandler( ){
  var element_clicked = $(this);
  element_clicked.siblings('.progress-bar').show();
  var params = {};
  params['filter_basis'] = $("input:radio:checked").val();
  params['revenue_date'] = $('#revenue_date').val();
  revenueReport(params, element_clicked ); 
} 

function revenueReport( params, element_clicked ){
  $.ajax({
    url: "/report/generate",
    type: "POST",
    dataType: "html",
    data: params,
    success: function(response){
      $('#tables_div').html(response);
      $('.total_involvement').each(function(){
        var available = 100 - parseInt( $(this).text() );
        var row = new Row( $(this), available );
        row.format();
      });
    },
    complete: function( jqXHR ){
      setTimeout(function(){
        $('.progress-bar').hide();
      },1000);
      $('.report_link').tooltip({
        html: true
      });
    }
  });
}

function utilizationHandler(){
  $("#utilization_date").datepicker({
    dateFormat: "dd M yy",
    onSelect: utilizationPageHandler
  });

  $('#from_date, #till_date').datepicker({
    dateFormat: "dd M yy"
  });

  $("#pie_report_date").datepicker({
    dateFormat: "dd M yy",
    onSelect: utilizationPageHandler
  });
}

function utilizationTableHandler(report_date){
  var ajax_url = $("#utilization_date").data('url');
  var sort_order = $('#availability-column').data('order');
  var params = {};
  params['utilization_date'] = report_date;
  params['order'] = sort_order ;
  $.ajax({
    url: ajax_url,
    type: "GET",
    async: true,
    dataType: "Script",
    data: params,
    beforeSend: function(){
      $('#utilization_date').siblings('.progress_bar').show();
      $("#ui-datepicker-div").hide();
    },
    complete: function(){
      $('#utilization_date').siblings('.progress_bar').hide();
    },
    success: function(){
      formatRows();
    }
  });
  // $( "#utilization_date" ).val(report_date);
  $( "#utilization_date" ).datepicker( "setDate", report_date );
}

function utilizationPageHandler(report_date){
  //Pie report related Logic
  var ajax_url = $("#pie_report_date").data('url');
  var params = {};
  params['utilization_date'] = report_date;
  params['id'] = $('.breadcrumb li.active').data('id');
  params['key'] = $('.breadcrumb li.active').data('key');
  $.ajax({
    url: "/report/pie_report",
    type: "GET",
    async: true,
    dataType: "Script",
    data: params,
    beforeSend: function(){
      $('#pie_report_date').siblings('.progress_bar').show();
      $("#ui-datepicker-div").hide();
    },
    complete: function(){
      $('#pie_report_date').siblings('.progress_bar').hide();
    }
  });
  $( "#pie_report_date" ).datepicker( "setDate", report_date );
  
  // Utilization Report Logic
  utilizationTableHandler(report_date);


  // Monthly Billing tab logic
  var params = { 'billing_date': report_date }
  $.ajax({
    url: "/report/billings",
    type: "GET",
    async: true,
    dataType: "html",
    data: params,
    success: function( response ){
      $('#billings_table').html(response);
    },
    beforeSend: function(){
      $('#billing_date').siblings('.progress_bar').show();
      $("#ui-datepicker-div").hide();
    },
    complete: function(){
      $('#billing_date').siblings('.progress_bar').hide();
    }
  });
  var billing_date = $.datepicker.formatDate( "M yy", new Date(report_date) );
  $( "#billing_date" ).val(billing_date);


  // Availability table logic
  if ($availabilty_tab_refreshed){
    $( "#from_date" ).datepicker( "setDate", report_date );
    var till_date = new Date(report_date);
    var till_date = new Date( till_date.setMonth(till_date.getMonth() + 1) )
    
    $( "#till_date" ).datepicker( "setDate", till_date );
    var params = {
      'from_date' : report_date,
      'till_date' : till_date
    }
    $.ajax({
      url: "/report/relieving_employees",
      type: "POST",
      async: true,
      dataType: "Script",
      data: params,
      beforeSend: function(){
        $('#availability_utilization').siblings('.progress_bar').show();
        $("#ui-datepicker-div").hide();
      },
      complete: function(){
        $('#availability_utilization').siblings('.progress_bar').hide();
      }
    });
  }

  $availabilty_tab_refreshed = true
  $('.hasDatepicker').blur();
  $('.report_link').tooltip({
    html: true
  });

  $('#relievingEmployeesTable').tablesorter({
    headers: {
      0: { sorter: false },
      1: { sorter: false },
      2: { sorter: false }
    }
  });
}
