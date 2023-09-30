class Post < ApplicationRecord
  #TODO: アソシエーション
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorit_users, through: :favorites, source: :user
  
  #TODO: 公開・非公開機能
  #TODO: scope :is_published_flag, -> {where(is_published_flag: 1)}
  #TODO: scope :is_published_flag, -> {where(is_published_flag: 0)}
  enum is_published_flag: { published: 0, unpublished: 1 }
  #TODO: バリデーション
  validates :body, presence: true
  validates :is_published_flag, presence: true
  
  #TODO: いいね機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  #TODO: 検索機能
  #TODO: selfはモデル名（メソッドが記述されているモデルを表す）
  def self.search_for(content)
  #TODO: 完全一致
  #if method == 'perfect'
    #Post.where(body: content)
  #TODO: 前方一致
  #elsif method == 'forward'
    #Post.where('body LIKE ?', content+'%')
  #TODO: 後方一致
  #elsif method == 'backward'
    #Post.where('body LIKE ?', '%'+content)
  #else
  #TODO: 部分一致
  #TODO: LIKE句 カラム名、LIKE、？, 右にWord, 右のWordが？代入
  #TODO: %は全ての文字
    Post.where('body LIKE ?', '%'+content+'%')
  #end
  end
  
end
