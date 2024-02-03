require 'rails_helper'
RSpec.describe 'userpostpage#show', type: :feature do
  before do
    @user = User.create(name: 'Afimia Fidelis',
                        photo: 'https://res.cloudinary.com/dsfuiu63q/image/upload/v1678870006/avatars/icon-256x256_wa30f0.png',
                        bio: 'Fullstack Dev Freelance',
                        posts_count: 0)
    @post1 = Post.create(author_id: @user.id, title: 'My First Post', text: 'This is the content of my first post.',
                         likes_count: 0, comments_count: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Rails Rocks', text: 'Excited about Rails development!',
                         likes_count: 0, comments_count: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Learning Ruby', text: 'Exploring the beauty of Ruby language.',
                         likes_count: 0, comments_count: 0)
    visit user_path(@user.id)
  end

  it 'I can see the user\'s profile picture' do
    expect(page).to have_css("img[src*='https://res.cloudinary.com/dsfuiu63q/image/upload/v1678870006/avatars/icon-256x256_wa30f0.png']")
  end

  it 'I can see the user\'s profile name' do
    expect(page).to have_content 'Afimia Fidelis'
  end

  it 'I can see the number of posts the user has written' do
    expect(page).to have_content 'Number of Posts: 3'
  end

  it 'I can see the user\'s bio' do
    expect(page).to have_content 'Fullstack Dev Freelance'
  end

  it 'I can see the user\'s first 3 posts' do
    expect(page).to have_content('This is the content of my first post.')
    expect(page).to have_content('Excited about Rails development!')
    expect(page).to have_content('Exploring the beauty of Ruby language.')
  end

  it 'I can see a button that lets me view all of a user\'s posts' do
    expect(page).to have_link('See all posts')
  end

  it "When I click a user's post, it redirects me to that post's show page." do
    click_on 'My First Post'
    expect(page).to have_content 'This is the content of my first post.'
  end

  it " When I click to see all posts, it redirects me to the user's post's index page. " do
    click_on 'See all posts'
    expect(page).to have_content 'Afimia Fidelis'
  end
end
