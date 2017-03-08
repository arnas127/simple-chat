FactoryGirl.define do
  factory :message do
    original_message 'original'
    translated_message 'translated'
    user
  end
end
