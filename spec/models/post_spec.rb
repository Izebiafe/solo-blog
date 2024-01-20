# spec/models/post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:author) { User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Software Developer from Ethiopia.') }
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

  describe '#recent_comment' do
    it 'returns an empty array when there are no comments' do
      expect(post.recent_comment).to eq([])
    end

    it 'returns the most recent comment when there is only one comment' do
      comment = Comment.create(user_id: author.id, post_id: post.id, text: 'This is a comment')
      post.reload
      expect(post.recent_comment).to eq([comment])
    end
  end

  describe 'validations' do
    it 'requires likes_count to be an integer greater than or equal to 0' do
      post.likes_count = -1
      expect(post).to_not be_valid
      expect(post.errors[:likes_count]).to include('must be greater than or equal to 0')

      post.likes_count = 1.5
      expect(post).to_not be_valid
      expect(post.errors[:likes_count]).to include('must be an integer')

      post.likes_count = nil
      expect(post).to_not be_valid
      expect(post.errors[:likes_count]).to include('is not a number') # Updated expectation
    end

    it 'requires comments_count to be an integer greater than or equal to 0' do
      post.comments_count = -1
      expect(post).to_not be_valid
      expect(post.errors[:comments_count]).to include('must be greater than or equal to 0')

      post.comments_count = 1.5
      expect(post).to_not be_valid
      expect(post.errors[:comments_count]).to include('must be an integer')

      post.comments_count = nil
      expect(post).to_not be_valid
      expect(post.errors[:comments_count]).to include('is not a number') # Updated expectation
    end
  end
  describe 'methods' do
    describe '#update_counter' do
      it 'updates the post counter after saving a comment' do
        author = User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                             bio: 'Software Developer from Ethiopia.')
        post = Post.create(title: 'hello world', text: 'Hello world paragraph', author_id: author.id)
        Comment.create(user_id: author.id, post_id: post.id, text: 'This is a comment')

        # Ensure the counter is updated
        expect(post.reload.comments_count).to eq(1)
      end
    end

    describe '#recent_comment' do
      it 'returns an empty array when there are no comments' do
        expect(post.recent_comment).to eq([])
      end

      it 'returns the most recent comment when there is only one comment' do
        author = User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                             bio: 'Software Developer from Ethiopia.')
        post = Post.create(title: 'hello world', text: 'Hello world paragraph', author_id: author.id)
        comment = Comment.create(user_id: author.id, post_id: post.id, text: 'This is a comment')

        expect(post.recent_comment).to eq([comment])
      end

      it 'returns the most recent comments (up to 5) when there are multiple comments' do
        author = User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                             bio: 'Software Developer from Ethiopia.')
        post = Post.create(title: 'hello world', text: 'Hello world paragraph', author_id: author.id)
        comments = []

        # Create 7 comments
        7.times do |i|
          comments << Comment.create(user_id: author.id, post_id: post.id, text: "Comment #{i}")
        end

        # Ensure recent_comment returns the last 5 comments in the correct order
        expect(post.recent_comment).to eq(comments.last(5).reverse)
      end
    end
  end
end
