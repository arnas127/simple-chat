$(document).ready ->
  messageContainer = $('#messages')
  currentUsername = $('body').data('username')
  messageField = $('#message')

  autoScroll = () ->
    messageContainer.scrollTop(messageContainer.prop("scrollHeight"))

  messageField.focus()
  autoScroll()

  addMessage = (message) ->
    messageDate = $('<div/>').addClass('msg-date')
    messageDate = messageDate.text(message.time)

    messageAuthor = $('<div/>').addClass('msg-author')
    messageAuthor = messageAuthor.text(message.user)

    messageHeader = $('<div/>').addClass('msg-header')
    messageHeader = messageHeader.append(messageAuthor)
    messageHeader = messageHeader.append(messageDate)

    if currentUsername == message.user
      removeIcon = $('<i/>').addClass('fa fa-times')
      messageActions = $('<div/>').addClass('msg-actions')
      messageActions = messageActions.append(removeIcon)
      messageHeader = messageHeader.append(messageActions)

    messageText = $('<div/>').addClass('msg-text')
    messageText = messageText.text(message.text)

    messageWrapper = $('<div/>').addClass('msg-wrapper')
    messageWrapper = messageWrapper.append(messageHeader)
    messageWrapper = messageWrapper.append(messageText)

    messageIconContainer = $('<div/>').addClass('msg-icon')
    messageIcon = $('<i/>').addClass("fa fa-2x fa-#{message.icon}")

    messageIconContainer = messageIconContainer.append(messageIcon)

    messageRow = $('<div/>').addClass('message')
    messageRow = messageRow.attr('data-id', message.id)
    messageRow = messageRow.append(messageIconContainer)
    messageRow = messageRow.append(messageWrapper)

    messageContainer.append(messageRow)
    autoScroll()

  UpdateUsersList = (users) ->
    usersContainer = $('#users .container')
    usersContainer.empty()
    for user in users
      userRow = $('<div/>').addClass('user')
      usersContainer.append(userRow.text(user))

  removeMessage = (id) ->
    messageContainer.find(".message[data-id='#{id}']").remove()

  App.messages = App.cable.subscriptions.create "MessagesChannel",
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      addMessage(data['message']) if data['message']
      UpdateUsersList(data['users']) if data['users']
      removeMessage(data['remove']) if data['remove']

    post: (message) ->
      @perform 'post', message: message

    remove: (id) ->
      @perform 'remove', id: id

  messageField.on 'keypress', (event) ->
    if event.keyCode is 13 # return/enter = send
      App.messages.post event.target.value
      event.target.value = ''
      event.preventDefault()

  messageContainer.on 'mousedown', '.msg-actions > .fa-times', (event) ->
    App.messages.remove $(event.target).closest('.message').data('id')


