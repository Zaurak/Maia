$ ->
  $('.tags_with_autocomplete').autocomplete
    minLength: 3
    source: (request, response) ->
      $.ajax
        url: $('.tags_with_autocomplete').data('autocompleteurl')
        dataType: "json"
        data:
          name: request.term
        success: (data) ->
          response(data)
    open: ->
      $('.ui-autocomplete').width('auto');
      $('.ui-widget-content').css('background', '#B0B0B0');
      $('.ui-menu-item a').removeClass('ui-corner-all');
      false
