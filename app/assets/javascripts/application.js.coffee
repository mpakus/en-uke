#= require jquery
#= require jquery_ujs
#= require_tree .

EnUke = ->
  return if window.started? && window.started
  window.started = true

  $('#user_links').on 'click', '.keep-status', (e)->
    id = $(@).data('id')
    return unless id?
    $.ajax
      url: '/links/keep.json'
      type: 'POST'
      dataType: 'json'
      data: {user_token: window.user_token, id: id}
      success: (resp)=>
        if resp.status? and resp.status.code == 200
          if(resp.link.state == 0)
            $(@).removeClass('glyphicon-star').removeClass('color-blue').addClass('color-gray').addClass('glyphicon-star-empty')
          else
            $(@).removeClass('glyphicon-star-empty').removeClass('color-gray').addClass('color-blue').addClass('glyphicon-star')
      error: (xhr, status, err)->
    return false

$(document).on 'ready', ->
  EnUke()
