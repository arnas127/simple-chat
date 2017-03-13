class User < ApplicationRecord
  has_many :messages, dependent: :destroy

  enum dialect: {
    valley: 'Valley Girl',
    yoda: 'Yoda',
    binary: 'Binary'
  }

  validates :username, presence: true
  validates :dialect, presence: true, inclusion: { in: dialects.keys }

  def dialect_icon
    case dialect
    when 'valley'
      'venus'
    when 'binary'
      'calculator'
    when 'yoda'
      'rocket'
    end
  end
end
