require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:user) { User.create(name: 'marry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Software Developer from Spain.') }
  subject(:post) { Post.create(title: 'hello world', text: 'Hello world paragraph', author_id: user.id) }
  subject(:comment) { Comment.create(user_id: user.id, post_id: post.id, text: 'this is my comment') }

  it 'should be a valid comment' do
    expect(comment).to be_valid
  end

  it 'comment should match' do
    expect(comment.text).to eq 'this is my comment'
  end

  it 'post comment should be updated on comment save' do
    expect(comment.post.comments.size).to be(1)
  end

  it 'comment user id should be the same' do
    expect(comment.user_id).to eq(user.id)
  end

  it 'comment post id should be the same' do
    expect(comment.post.id).to eq(post.id)
  end

  it 'should be invalid on negative comment counter' do
    comment.post.comments_count = -1
    expect(comment.post).to_not be_valid
  end

  it 'should be invalid on non-integer comment counter' do
    comment.post.comments_count = 'test'
    expect(comment.post).to_not be_valid
  end

  it 'should be invalid if comments_count is negative' do
    post.comments_count = -1
    expect(post).to_not be_valid
  end
end
