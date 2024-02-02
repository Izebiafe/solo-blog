class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.includes(posts: %i[comments author]).find(params[:id])
    @posts = @user.recentposts
  end
end
