class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def mostrecentcomments
    comments.order(created_at: :desc).limit(5)
  end
  after_create :incrementpostcounter

  private

  def incrementpostcounter
    author.increment!(:posts_counter)
  end
end
