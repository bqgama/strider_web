FactoryBot.define do
  factory :friendship do
    follower_id { User.first.id }
    following_id { User.second.id }
  end
end