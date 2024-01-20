class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id', counter_cache: true

  after_save :updatepostcounter

  private

  def updatepostcounter
    post.update(likes_count: post.likes.count)
  end
end