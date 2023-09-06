class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :post
  has_many :comment_favorites, dependent: :destroy
  
    
  def favorited_by?(user)
    comment_favorites.exists?(user_id: user.id)
  end
  
end
