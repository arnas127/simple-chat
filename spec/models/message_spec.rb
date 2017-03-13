require 'rails_helper'

RSpec.describe Message, type: :model do
   it 'is valid with valid attributes' do
    user = User.create(username: 'user', dialect: 'yoda')
    expect(Message.new(user_id: user.id, original_message: 'test')).to be_valid
  end

  it 'is not valid without a original_message' do
    user = User.create(username: 'user', dialect: 'yoda')
    expect(Message.new(user_id: user.id)).not_to be_valid
  end

  it 'is not valid without a user' do
    expect(Message.new(original_message: 'test')).not_to be_valid
  end
end
