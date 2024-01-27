class AppController < ApplicationController
  def index; end
  helper_method :current_user

  def current_user
    User.first
  end
end
