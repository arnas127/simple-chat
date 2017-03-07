class MessagesChannel < ApplicationCable::Channel
  def subscribed
    ActiveUsersCounter.add(current_user.username)
    stream_from 'messages_channel'
  end

  def unsubscribed
    ActiveUsersCounter.remove(current_user.username)
  end

  def post(data)
    message = current_user.messages.create(original_message: data['message']).translated_message

    ActionCable.server.broadcast 'messages_channel', message: message, users: ActiveUsersCounter.get
  end
end
