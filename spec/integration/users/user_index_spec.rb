require 'rails_helper'
RSpec.describe 'userpage#index', type: :feature do
  before do
    @users = [
      User.create(name: 'Afimia Fidelis',
                  photo: 'https://res.cloudinary.com/dsfuiu63q/image/upload/v1678870006/avatars/Basic_Ui__28186_29_kgczha.jpg',
                  bio: 'Frontend Developer',
                  posts_count: 0),
      User.create(name: 'Folden',
                  photo: 'https://res.cloudinary.com/dsfuiu63q/image/upload/v1678870006/avatars/Basic_Ui__28186_29_kgczha.jpg',
                  bio: 'Web Technician',
                  posts_count: 0),
      User.create(name: 'Maya.',
                  photo: 'https://res.cloudinary.com/dsfuiu63q/image/upload/v1678870006/avatars/Basic_Ui__28186_29_kgczha.jpg',
                  bio: 'food lover',
                  posts_count: 0)
    ]

    @posts = [
      @post1 = Post.create(author_id: @user, title: 'Frontend Post One', text: 'This is Post One'),
      @post2 = Post.create(author_id: @user, title: 'Web Post Two', text: 'This is User Post Two'),
      @post3 = Post.create(author_id: @user, title: 'Foodie Post Three', text: 'This is User Post Three')

    ]
    visit users_path
  end
  describe '#index page' do
    it 'can view the usernames of all other users.' do
      @users.each do |user|
        expect(page).to have_content(user.name)
      end
    end
    it 'can view a profile picture for a given user.' do
      @users.each do |user|
        expect(page).to have_css("img[src='#{user.photo}']")
      end
    end
    it 'can check the amount of posts a user has written.' do
      @users.each do |user|
        expect(page).to have_content(user.posts_count.to_s)
      end
    end
    it 'redirects to the user show page when a user is clicked' do
      page.all('div.col-lg-12.border.border-dark').each_with_index do |el, _i|
        within(el) { expect(page).to have_current_path(user_path(user)) }
      end
    end
  end
end
