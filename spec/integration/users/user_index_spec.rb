require 'rails_helper'

RSpec.describe 'userpage#index', type: :feature do
  before do
    @users = [
      User.create(name: 'Devendra',
                  photo: 'https://res.cloudinary.com/dsfuiu63q/image/upload/v1678870006/avatars/Basic_Ui__28186_29_kgczha.jpg',
                  bio: 'Fullstack Engineer',
                  posts_count: 0),
      User.create(name: 'John',
                  photo: 'https://res.cloudinary.com/dsfuiu63q/image/upload/v1678870006/avatars/Basic_Ui__28186_29_kgczha.jpg',
                  bio: 'Web Developer',
                  posts_count: 0),
      User.create(name: 'James K.',
                  photo: 'https://res.cloudinary.com/dsfuiu63q/image/upload/v1678870006/avatars/Basic_Ui__28186_29_kgczha.jpg',
                  bio: 'Kindergarten Teacher',
                  posts_count: 0)
    ]

    @posts = [
      @post1 = Post.create(author_id: @user, title: 'Developer Post One', text: 'This is Post One'),
      @post2 = Post.create(author_id: @user, title: 'Teacher Post Two', text: 'This is User Post Two'),
      @post3 = Post.create(author_id: @user, title: 'Admin Post Three', text: 'This is User Post Three')
    ]

    visit users_path
  end

  describe '#index page' do
    it 'displays the usernames of all other users.' do
      @users.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'displays a profile picture for each user.' do
      @users.each do |user|
        expect(page).to have_css("img[src='#{user.photo}']")
      end
    end

    it 'displays the number of posts each user has written.' do
      @users.each do |user|
        expect(page).to have_content(user.posts_count.to_s)
      end
    end
  end
end
