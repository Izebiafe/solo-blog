require 'rails_helper'

RSpec.describe 'Posts#index', type: :feature do
  before :each do
    @user = User.create(name: 'John Doe', photo: 'https://example.com/john-doe.jpg', bio: 'Web Developer',
                        posts_count: 0)
    @post1 = Post.create(author_id: @user.id, title: 'Ruby on Rails', text: 'Learn, engage, and explore.',
                         likes_count: 2, comments_count: 1)
    @post2 = Post.create(author_id: @user.id, title: 'Linters Management', text: 'Many ways to solve a problem.',
                         likes_count: 0, comments_count: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Ruby Adventures', text: 'Discovering the beauty.',
                         likes_count: 1, comments_count: 2)
    @comment = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'Great post!')
    visit user_posts_path(@user.id)
  end

  it 'displays the user\'s profile picture' do
    expect(page).to have_css("img[src*='https://example.com/john-doe.jpg']")
  end

  it 'displays the user\'s username' do
    expect(page).to have_content('John Doe')
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content('Number of Posts: 3')
  end

  it 'displays a post\'s title' do
    expect(page).to have_content('Ruby on Rails')
  end

  it 'displays some of the post\'s body' do
    expect(page).to have_content('Many ways to solve a problem.')
  end

  it 'displays the first comments on a post' do
    expect(page).to have_content('Great post!')
  end

  it 'displays how many comments a post has' do
    expect(page).to have_content('Comments: 2')
  end

  it 'displays how many likes a post has' do
    expect(page).to have_content('Likes: 2')
  end

  it 'displays a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_content('Pagination')
  end

  it "redirects to a post's show page when clicked" do
    click_on 'Ruby on Rails'
    expect(page).to have_content('Ruby on Rails')
  end
end
