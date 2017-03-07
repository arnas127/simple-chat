class MessagingController < ApplicationController
  def index
    @messages = Message.all
  end

  def create
    head :ok
  end
end
