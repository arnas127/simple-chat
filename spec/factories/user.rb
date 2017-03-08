FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    dialect 'yoda'

    trait :valley do
      dialect 'valley'
    end

    trait :binary do
      dialect 'binary'
    end
  end
end
