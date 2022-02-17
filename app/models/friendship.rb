class Friendship < ApplicationRecord
  belongs_to :followers, class_name: 'User', foreign_key: :follower_id
  belongs_to :followings, class_name: 'User', foreign_key: :following_id

  scope :users_im_following, ->(user_id) {
    where(follower_id: user_id)
  }
end
