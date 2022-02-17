class Friendship < ApplicationRecord
  validate :not_follow_myself

  belongs_to :followers, class_name: 'User', foreign_key: :follower_id
  belongs_to :followings, class_name: 'User', foreign_key: :following_id

  scope :users_im_following, ->(user_id) {
    where(follower_id: user_id)
  }

  private
  def not_follow_myself
    if follower_id == following_id
      errors.add(:following_id, "You can't follow yourself")
    end
  end
end
