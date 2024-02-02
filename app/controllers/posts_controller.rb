class PostsController < ApplicationController
  before_action :find_user, only: [:index, :show, :new, :create]

  def index
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = @user.posts.includes(:comments).find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = @user.posts.new
  end

  def create
    @post = @user.posts.build(post_params.merge(author: current_user))

    if @post.save
      redirect_to user_posts_path(id: current_user.id), notice: 'Post created successfully!'
    else
      flash.now[:alert] = 'Cannot create a new post'
      render :new
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
