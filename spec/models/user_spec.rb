require 'rails_helper'

RSpec.describe User, type: :model do
   it 'is valid with valid attributes' do
    expect(User.new(username: 'user', dialect: 'yoda')).to be_valid
  end

  it "is not valid without a usersname" do
    expect(User.new(dialect: 'yoda')).to_not be_valid
  end

  it "is not valid without a dialect" do
    expect(User.new(username: 'user')).to_not be_valid
  end
end
