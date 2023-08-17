class User::PostsController < ApplicationController
  
  def index
  end
  
  def show
  end
  
  def new
  end
  
  def create
  end
  
  def destroy
  end
  
  private
   
  def post_params
    params.require(:post).permit(:user_id, :comment, :body, :image)  
  end
  
end
