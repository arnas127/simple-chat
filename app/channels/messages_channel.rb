class MessagesChannel < ApplicationCable::Channel
  CHANELL_NAME = 'messages_channel'

  def subscribed
    ActiveUsersCounter.add(current_user.username)
    stream_from CHANELL_NAME
    broadcast_users_change
  end

  def unsubscribed
    ActiveUsersCounter.remove(current_user.username)
    broadcast_users_change
  end

  def post(data)
    message = prepare_message_data(data['message'])
    ActionCable.server.broadcast CHANELL_NAME, message: message, users: ActiveUsersCounter.get
  end

  private

  def broadcast_users_change
    ActionCable.server.broadcast CHANELL_NAME, users: ActiveUsersCounter.get
  end

  def prepare_message_data(input_text)
    message = current_user.messages.create(original_message: input_text)

    {
      text: message.translated_message,
      time: message.created_at,
      user: current_user.username,
      icon: current_user.dialect_icon
    }
  end
end
