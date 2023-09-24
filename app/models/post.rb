class Post < ApplicationRecord
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorit_users, through: :favorites, source: :user
  
  scope :published, -> {where(is_published_flag: true)}
  scope :unpublished, -> {where(is_published_flag: false)}
  
  validates :body, presence: true
  validates :is_published_flag, presence: true
  
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
    #favorites.exists?(user_id: user.id)
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
