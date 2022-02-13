class Post < ApplicationRecord
  belongs_to :user

  validates :body,
    presence: true,
    length: { maximum: 777 },
    on: :create

    enum kind: { original: 0, repost: 1, quote_posting: 2 }
end
