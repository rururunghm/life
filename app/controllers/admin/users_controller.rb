class Admin::UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def user_post
    @post = current_user
  end
  
  def user_comment
    @comment = Comment.all
    #@user = current_user
  end
  
end
