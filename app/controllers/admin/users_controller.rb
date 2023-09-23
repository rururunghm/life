class Admin::UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def user_post
    @user = current_user
  end
  
  def user_comment
    @user = current_user
  end
  
end
