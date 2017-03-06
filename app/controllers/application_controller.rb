class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :prepare_user
  before_action :authenticate_user

  private

  def prepare_user
    @current_user = User.find_by_id(session[:user_id]) if session[:user_id].present? # don't use find to prevent exeptions raising
  end

  def authenticate_user
    redirect_to root_path unless @current_user
  end
end
