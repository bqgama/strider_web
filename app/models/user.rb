class User < ApplicationRecord
  has_many :follower_list, foreign_key: :following_id, class_name: 'Friendship'
  has_many :followers, through: :follower_list

  has_many :following_list, foreign_key: :follower_id,  class_name: 'Friendship'
  has_many :followings, through: :following_list

  validates :username,
    presence: true,
    length: { maximum: 14 },
    format: { with: /\A[A-Za-z0-9]+\z/,
      message: "only allows letters and numbers" },
    on: :create

  def number_of_followers
    followers.count
  end

  def number_of_followings
    followings.count
  end
end
