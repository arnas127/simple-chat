# frozen_string_literal: true
module Authentication
  extend ActiveSupport::Concern

  def sign_in(user)
    @request.session['user_id'] = user.id
  end
end

RSpec.configure do |config|
  config.include Authentication
end
