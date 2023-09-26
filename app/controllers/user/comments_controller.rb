class User::CommentsController < ApplicationController
  
  def create
  
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to posts_path(post)
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end
  
  def favorite
  
    @favorite_posts = current_user.favorited_posts
  
  end

  private
   
  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :comment)  
  end
  
end
