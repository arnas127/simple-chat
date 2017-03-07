App.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log(data['message'])
    console.log(data['users'])

    addMessage(data['message']) if data['message']

  post: (message) ->
    @perform 'post', message: message


addMessage = (message) ->
  console.log('adding')
  console.log(message.time)
  console.log(message)
  messageContainer = $('#messages')

  messageDate =  $('<div/>').addClass('msg-date')
  messageDate = messageDate.text(message.time)

  messageAuthor =  $('<div/>').addClass('msg-author')
  messageAuthor = messageAuthor.text(message.user)

  messageHeader =  $('<div/>').addClass('msg-header')
  messageHeader = messageHeader.append(messageAuthor)
  messageHeader = messageHeader.append(messageDate)

  messageText =  $('<div/>').addClass('msg-text')
  messageText = messageText.text(message.text)

  messageWrapper =  $('<div/>').addClass('msg-wrapper')
  messageWrapper = messageWrapper.append(messageHeader)
  messageWrapper = messageWrapper.append(messageText)

  messageIconContainer =  $('<div/>').addClass('msg-icon')
  messageIcon =  $('<i/>').addClass("fa fa-2x fa-#{message.icon}")

  messageIconContainer = messageIconContainer.append(messageIcon)

  messageRow =  $('<div/>').addClass('message')
  messageRow = messageRow.append(messageIconContainer)
  messageRow = messageRow.append(messageWrapper)

  messageContainer.append(messageRow)
  messageContainer.scrollTop(messageContainer.prop("scrollHeight"))

$(document).on 'keypress', '#message', (event) ->
  if event.keyCode is 13 # return/enter = send
    App.messages.post event.target.value
    event.target.value = ''
    event.preventDefault()


