class User::PostsController < ApplicationController
  
  def index
    # 皆の投稿表示画面
    @posts = Post.all
    @user = current_user
    # 公開された記事のみ表示
    #@posts = Post.published
    
  end
  
  def favorite
    # いいね画面
    #favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
   # @favorite_posts = Post.find(favorites)
    @favorite_posts = current_user.favorited_posts
  end
  
  def my_post
    # 自分の投稿表示画面
    @post = current_user.posts
  end
  
  def other_user
    # ほかのユーザの投稿表示画面
    @user = User.find(params[:id])

  end
  
  def new
    # 新規投稿
    @user = current_user
    @post = Post.new
  end
  
  def show
    # コメント投稿画面
    @post = Post.find(params[:id])
    @user = current_user
    @comment = Comment.new
    @post = Post.unpublished
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
    @post.is_published_flag = post_params[:is_published_flag]
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
    params.require(:post).permit(:user_id, :body, :is_published_flag)  
  end
  
  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end
  
end
