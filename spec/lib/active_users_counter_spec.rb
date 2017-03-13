require 'rails_helper'

RSpec.describe ActiveUsersCounter do
  after(:each) { ActiveUsersCounter.instance_variable_set :@users_list, nil }

  it 'set counter correctly' do
    expect(ActiveUsersCounter.add('test')).to eq(1)
    expect(ActiveUsersCounter.add('test2')).to eq(1)
    expect(ActiveUsersCounter.add('test2')).to eq(2)
    expect(ActiveUsersCounter.remove('test2')).to eq(1)
  end

  it 'show correct users amount' do
    ActiveUsersCounter.add('test3')
    ActiveUsersCounter.add('test3')
    ActiveUsersCounter.add('test4')
    expect(ActiveUsersCounter.get).to eq(['test3', 'test4'])
  end
end
