class Post < ApplicationRecord
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorit_users, through: :favorites, source: :user
  
  has_one_attached :image
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(body: content)
    elsif method == 'forward'
      Post.where('body LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('body LIKE ?', '%'+content)
    else
      Post.where('body LIKE ?', '%'+content+'%')
    end
  end
  
end
