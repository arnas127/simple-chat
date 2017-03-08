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

  def remove(data)
    id = data['id']
    ActionCable.server.broadcast(CHANELL_NAME, remove: id, users: ActiveUsersCounter.get) if handle_message_deletion(id)
  end

  private

  def handle_message_deletion(id)
    message = Message.find_by_id(id)
    if current_user.id == message.user_id
      message.destroy
      true
    else
      false
    end
  end

  def broadcast_users_change
    ActionCable.server.broadcast CHANELL_NAME, users: ActiveUsersCounter.get
  end

  def prepare_message_data(input_text)
    message = current_user.messages.create(original_message: input_text)

    {
      id: message.id,
      text: message.translated_message,
      time: message.created_at.to_s,
      user: current_user.username,
      icon: current_user.dialect_icon
    }
  end
end
