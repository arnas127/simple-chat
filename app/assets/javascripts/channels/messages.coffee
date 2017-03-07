App.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    alert(data['message'])

  post: (message)->
    @perform 'post', message: message


$(document).on 'keypress', '#message', (event) ->
  if event.keyCode is 13 # return/enter = send
    App.messages.post event.target.value
    event.target.value = ''
    event.preventDefault()
