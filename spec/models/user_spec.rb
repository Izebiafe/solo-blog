require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create(name: 'James', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Software Developer from Kenya.') }

  it 'is valid subject' do
    expect(user).to be_valid
  end

  it 'is not valid without name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'should return post count as zero' do
    expect(user.posts.size).to be(0)
  end

  it 'should return post count as one' do
    post = Post.create(title: 'hello', text: 'hello world test', author_id: user.id)
    expect(user.reload.posts.size).to eq(1)  # Added "reload" to ensure the latest data is used
  end

  it 'should be invalid on non-integer post counter' do
    user.posts_count = 'dd'
    expect(user).to_not be_valid
  end

  it 'should be invalid for negative integer post counter' do
    user.posts_count = -1
    expect(user).to_not be_valid
  end
end
