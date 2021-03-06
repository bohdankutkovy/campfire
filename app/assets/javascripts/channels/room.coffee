App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#messages').append data['message']
    element = document.getElementById('panel-body')
    element.scrollTop = element.scrollHeight

  speak: (params) ->
    @perform 'speak', message: params[0], owner_id: params[1]

#========== Sending message on 'Enter' keypress ==========
$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 #true <- enter == send
    params = [event.target.value, event.target.getAttribute('owner-id')]
    App.room.speak params
    event.target.value = ''
    event.preventDefault()

#========== Sending message on btn click =========
$(document).on 'click', '#send-button', (event) ->
  input = document.getElementById('send-string')
  App.room.speak input.value
  input.value = ''
  event.preventDefault()
