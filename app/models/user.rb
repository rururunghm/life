class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.telephone_number = "08088888888"
      
    end
  end
  
  has_one_attached :image
  #TODO: アソシエーション
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :comment_favorites, dependent: :destroy
  #TODO: バリデーション
  validates :name, presence: true
  validates :telephone_number, presence: true
  validates :email, presence: true
  
  def get_profile_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
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
    User.where('name LIKE ?', '%' + content + '%')
  end
  
end
