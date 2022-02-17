FactoryBot.define do
  factory :user do
    username { FFaker::Name.first_name }
    date_joined { FFaker::Time.date }
  end
end