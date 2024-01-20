require 'rails_helper'

RSpec.describe Like, type: :model do
  subject(:user) { User.create(name: 'Kidshan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Software Developer from Portland.') }
  subject(:post) { Post.create(title: 'hello world', text: 'Hello world paragraph', author_id: user.id) }
  subject(:like) { Like.create(user_id: user.id, post_id: post.id) }

  it 'should be a valid like' do
    expect(like).to be_valid
  end

  it 'post like count should be 1' do
    expect(like.post.likes.size).to be(1)
  end

  it 'user like count should be 1' do
    expect(like.user_id).to eq(user.id)
  end

  it 'should be invalid on negative like counter' do
    like.post.likes_count = -1
    expect(like.post).to_not be_valid
  end

  it 'should not be valid for non-integer like counter' do
    like.post.likes_count = 'dd'
    expect(like.post).to_not be_valid
  end
  it 'should be invalid if likes_count is negative' do
    post.likes_count = -1
    expect(post).to_not be_valid
  end
end
