class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id', counter_cache: true

  after_save :update_commentcounter

  private

  def update_commentcounter
    post.update(comments_count: post.comments.size)
  end
end
