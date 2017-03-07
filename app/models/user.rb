class User < ApplicationRecord
  has_many :messages, dependent: :destroy

  enum dialect: {
    valley: 'Valley Girl',
    yoda: 'Yoda',
    binary: 'Binary'
  }

  def dialect_icon
    case dialect
    when 'valley'
      'venus'
    when 'binary'
      'calculator'
    when 'yoda'
      'rocket'
    else
      'asterisk'
    end
  end
end
