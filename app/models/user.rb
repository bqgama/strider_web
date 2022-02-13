class User < ApplicationRecord
  validates :username,
    presence: true,
    length: { maximum: 14 },
    format: { with: /\A[A-Za-z0-9]+\z/,
      message: "only allows letters" },
    on: :create
end
