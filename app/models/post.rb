class Post < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorit_users, through: :favorites, source: :user
  
  # 公開・非公開機能
  #scope :is_published_flag, -> {where(is_published_flag: 1)}
  #scope :is_published_flag, -> {where(is_published_flag: 0)}
  enum is_published_flags: { published: 0, unpublished: 1 }
  # バリデーション
  validates :body, presence: true
  validates :is_published_flag, presence: true
  
  # いいね機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  # 検索機能
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
