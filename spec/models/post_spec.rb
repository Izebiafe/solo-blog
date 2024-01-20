require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:author) { User.create(name: 'Essie', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Software Developer from Ethiopia.') }
  subject(:post) { Post.create(title: 'hello world', text: 'Hello world paragraph', author_id: author.id) }

  it 'should be a valid post' do
    expect(post).to be_valid
  end

  it 'should be invalid post' do
    post.title = nil
    expect(post).to_not be_valid
  end

  it 'should have post counter to 1' do
    expect(post.author.posts.size).to be(1)
  end
end
