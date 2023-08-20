class User::PostsController < ApplicationController
  
  def index
    @post = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def show
  end
  
  def create
    @post = Post.new(post_params)
  end
  
  def destroy
  end
  
  private
   
  def post_params
    params.require(:post).permit(:user_id, :comment, :body, :image)  
  end
  
end
