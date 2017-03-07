class MessagesChannel < ApplicationCable::Channel
  def subscribed
    puts "#{current_user.username}---on---------------------------------------------------------"
    stream_from 'messages_channel'
  end

  def unsubscribed
    puts "#{current_user.username}---off---------------------------------------------------------"
    # Any cleanup needed when channel is unsubscribed
  end

  def post(data)
    ActionCable.server.broadcast 'messages_channel', message: ActiveUsersCounter.get.to_s
  end
end
