$(function(){
  $(".chzn-select").chosen();
  
  $('#dataTable').dataTable({
    "bAutoWidth": false,
    "bLengthChange": false,
    "bRetrieve": true
  });
  
  $('#table_view').hide();
  if($.cookie("tab_selected") == null){
    $.cookie("tab_selected", "list_view");  
  }
  
  if($.cookie("tab_selected") == "list_view"){
      $('#list_view_tab').addClass('current');
      $('#table_view_tab').removeClass('current');
      $('li#time, li#description').show();
      $('#table_view').hide();
      $('#list_view').show();
  } else if($.cookie("tab_selected") == "table_view"){
      $('#list_view_tab').removeClass('current');
      $('#table_view_tab').addClass('current');
      $('li#time, li#description').hide();
      $('#list_view').hide();
      $('#table_view').show();
  }
  
  
  $('#view_list_view').bind('click',function() {
    if ($(this).hasClass('current')) {
    } else {
      $('#list_view_tab').addClass('current');
      $('#table_view_tab').removeClass('current');
      $('li#time, li#description').fadeIn(300);
      $('#table_view').hide();
      $('#list_view').fadeIn(300);
    }
    $.cookie("tab_selected", "list_view");
    return false
  });
  $('#view_table_view').bind('click',function() {
    if ($(this).hasClass('current')) {
    } else {
      $('#list_view_tab').removeClass('current');
      $('#table_view_tab').addClass('current');
      $('li#time, li#description').hide();
      $('#list_view').hide();
      $('#table_view').fadeIn(300);
    }
    $.cookie("tab_selected", "table_view");
    return false
  });
  
  $('#user_select_option, #message_select_option, #pet_select_option, #text_input_custom').hide();
  
  $('#news_feed_object').change(function(){
    $('#user_select_option').hide();
    $('#message_select_option').hide();
    $('#pet_select_option').hide();
    $('#text_input').hide();
    if ($('#news_feed_object').val() == "User") {
      if ($('#action_type').val() == "Create") {
        $('#text_input').show();
      } else if ($('#action_type').val() == "Update") {
        $('#user_select_option').show();
        $('#text_input').show();
      } else if ($('#action_type').val() == "Delete") {
        $('#user_select_option').show();
      } else if ($('#action_type').val() == "Send") {
        $('#user_select_option').show();
    }
    } else if ($('#news_feed_object').val() == "Message") {
      if ($('#action_type').val() == "Create") {
        $('#text_input').show();
      } else if ($('#action_type').val() == "Update") {
        $('#message_select_option').show();
        $('#text_input').show();
      } else if ($('#action_type').val() == "Delete") {
        $('#message_select_option').show();
      } else if ($('#action_type').val() == "Send") {
        $('#message_select_option').show();
    }
    } else if ($('#news_feed_object').val() == "Pet") {
      if ($('#action_type').val() == "Create") {
        $('#text_input').show();
      } else if ($('#action_type').val() == "Update") {
        $('#pet_select_option').show();
        $('#text_input').show();
      } else if ($('#action_type').val() == "Delete") {
        $('#pet_select_option').show();
      } else if ($('#action_type').val() == "Send") {
        $('#pet_select_option').show();
    }
    }
  });

  $('#action_type').change(function(){
    $('#user_select_option').hide();
    $('#message_select_option').hide();
    $('#pet_select_option').hide();
    $('#text_input').hide();
    $('#choose_actor').show();
    $('#choose_object').show();
    $('#text_input_custom').hide();
    if ($('#action_type').val() == "Create") {
      $('#text_input').show();
    } else if ($('#action_type').val() == "Update") {
      $('#text_input').show();
      if ($('#news_feed_object').val() == "User") {
        $('#user_select_option').show();
      } else if ($('#news_feed_object').val() == "Message") {
        $('#message_select_option').show();
      } else if ($('#news_feed_object').val() == "Pet") {
        $('#pet_select_option').show();
      }
    } else if ($('#action_type').val() == "Custom Message") {
      $('#text_input_custom').show();  
      $('#choose_actor').hide();
      $('#choose_object').hide();
    } else if ($('#action_type').val() == "Delete") {
      if ($('#news_feed_object').val() == "User") {
        $('#user_select_option').show();
      } else if ($('#news_feed_object').val() == "Message") {
        $('#message_select_option').show();
      } else if ($('#news_feed_object').val() == "Pet") {
        $('#pet_select_option').show();
      }
    } else if ($('#action_type').val() == "Send") {
      if ($('#news_feed_object').val() == "User") {
        $('#user_select_option').show();
      } else if ($('#news_feed_object').val() == "Message") {
        $('#message_select_option').show();
      } else if ($('#news_feed_object').val() == "Pet") {
        $('#pet_select_option').show();
      }
    }
  });
});

$(function(){
  $('li.by_news_feed').bind('hover',function(){
    $(this).find('.delete').toggle();
  });
});

