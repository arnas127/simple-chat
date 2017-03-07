class Message < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0}
  validates :original_message, presence: true

  after_validation :translate_message

  private

  def translate_message
    if original_message_changed?
      # self.translated_message = Translator.translate(original_message, user.dialect)
      self.translated_message = Translator.translate(original_message, 'binary')
    end
    true
  end
end
