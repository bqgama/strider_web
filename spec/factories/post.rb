FactoryBot.define do
  factory :post do
    body { FFaker::Name.first_name }
    user

    trait :original do
      kind { :original }
      parent_id { nil }
    end

    trait :repost do
      kind { :repost }
      parent_id { Post.first }
    end

    trait :quote_posting do
      kind { :quote_posting }
      parent_id { Post.first }
    end
  end
end