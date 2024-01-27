class User < ApplicationRecord
  has_many :comments, foreign_key: 'user_id'
  has_many :posts, foreign_key: 'author_id', primary_key: 'id'
  has_many :likes, foreign_key: 'user_id'

  validates :name, presence: true
  validates :posts_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recentposts
    posts.order(created_at: :desc).limit(5)
  end
end
