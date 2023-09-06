class User::PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end
  
  def favorite
    #favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
   # @favorite_posts = Post.find(favorites)
    @favorite_posts = current_user.favorited_posts
    
  end
  
  def new
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
   
  def post_params
    params.require(:post).permit(:user_id, :body, :image)  
  end
  
  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end
  
end
