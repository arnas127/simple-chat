class User < ApplicationRecord
  has_many :messages, dependent: :destroy

  enum dialect: {
    valley: 'Valley Girl',
    yoda: 'Yoda',
    binary: 'Binary'
  }
end
