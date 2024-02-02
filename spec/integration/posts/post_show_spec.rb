require 'rails_helper'

RSpec.describe 'Allpostpage#show', type: :feature do
  before :each do
    @user = User.create(name: 'Afimia Fidelis', photo: 'https://example.com/john-doe.jpg', bio: 'Web Developer',
                        posts_count: 0)
    @post1 = Post.create(author_id: @user.id, title: 'Rails Journey', text: 'Exploring the world of Rails development.',
                         likes_count: 0, comments_count: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Hello World', text: 'Another day, another hello.',
                         likes_count: 0, comments_count: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Ruby Adventures', text: 'Discovering the beauty.',
                         likes_count: 0, comments_count: 0)
    @comment1 = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'Great post!')
    @comment2 = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'I learned a lot.')
    @like = Like.create(user_id: @user.id, post_id: @post1.id)

    visit user_post_path(@user.id, @post1.id)
  end

  it 'displays the post\'s title' do
    expect(page).to have_content('Rails Journey')
  end

  it 'displays the author of the post' do
    expect(page).to have_content('Afimia Fidelis')
  end

  it 'displays the number of comments the post has' do
    expect(page).to have_content('Comments: 2')
  end

  it 'displays the number of likes the post has' do
    expect(page).to have_content('Likes: 1')
  end

  it 'displays the body of the post' do
    expect(page).to have_content('Exploring the world of Rails development.')
  end

  it 'displays the username of each commenter' do
    expect(page).to have_content(@comment1.author.name)
    expect(page).to have_content(@comment2.author.name)
  end

  it 'displays the comment left by each commenter' do
    expect(page).to have_content('Great post!')
    expect(page).to have_content('I learned a lot.')
  end
end
