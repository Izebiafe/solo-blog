class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_commentcounter

  private

  def update_commentcounter
    post.update(comments_counter: post.comments.size)
  end
end
