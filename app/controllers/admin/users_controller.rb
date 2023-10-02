class Admin::UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def user_post
    @posts = Post.all
  end
  
  def user_comment
    @comment = Comment.all
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_post_admin_users_path
  end
  
end
