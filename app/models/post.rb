class Post < ApplicationRecord
  has_many :posts, class_name: "Post", foreign_key: "parent_id"
  belongs_to :parent,  class_name: "Post", optional: true

  belongs_to :user

  validates :body,
    presence: true,
    length: { maximum: 777 },
    on: :create

  validate :original_post_dont_have_a_parent

  enum kind: { original: 0, repost: 1, quote_posting: 2 }

  scope :posts_made_by_this_user, ->(user_id) {
    where(user_id: user_id)
  }

  private
  def original_post_dont_have_a_parent
    if kind == "original" && parent_id != nil
      errors.add(:parent_id, "Original post do not have a parent")
    elsif kind != "original" && parent_id == nil
      errors.add(:parent_id, "Reposts and quote posts must have a parent")
    end
  end
end
