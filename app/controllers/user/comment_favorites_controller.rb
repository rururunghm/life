class User::CommentFavoritesController < ApplicationController
  def create
    comment = Comment.find(params[:comment_id])
    favorite = current_user.comment_favorites.new(comment_id: comment.id)
    favorite.save
    redirect_to posts_path(comment.post)
  end
  
  def destroy
    comment = Comment.find(params[:id])
    favorite = current_user.comment_favorites.find_by(comment_id: comment.id)
    favorite.destroy
    redirect_to posts_path(comment.post)
  end
end
