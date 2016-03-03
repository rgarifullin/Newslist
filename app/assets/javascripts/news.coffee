# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('.add_news').click ->
    $('#news_modal').modal('show')
    $('#news_author').val ''
    $('#news_text').val ''

  $('.create_new').click ->
    $('#news_modal').modal('hide')

  $('#new_news').on('ajax:complete', (e, data, status, xhr) ->
    $('.news').append data.responseText
  )
