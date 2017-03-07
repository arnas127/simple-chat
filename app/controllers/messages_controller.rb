class MessagesController < ApplicationController
  def index
    @messages = Message.all.includes(:user)
  end

  def create
    head :ok
  end
end
