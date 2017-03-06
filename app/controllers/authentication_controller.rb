class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user, only: [:index, :login]
  before_action :prepare_params, only: :login

  def index
    if @current_user
      handle_authenticated_user
    else
      render
    end
  end

  def login
    current_user = User.where(username:  @user_params[:username]).first_or_create(@user_params)
    session[:user_id] = current_user.id
    handle_authenticated_user
  end

  private

  def prepare_params
    @user_params = params.permit(:username, :dialects)
  end

  def handle_authenticated_user
    redirect_to messaging_path
  end
end
