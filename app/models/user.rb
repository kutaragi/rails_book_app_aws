class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         attachment :profile_image

  has_many :books, dependent: :destroy

  validates :name, length: {minimum: 2, maximum:20}, presence: true

  validates :introduction, length: {maximum: 50}

  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy

  has_many :user_rooms

  has_many :chats

  # 一つのテーブルに対して二つのリレーションがあるから(ないと関連づけられない)フォローする/フォローされるの二つのリレーションを作成
  #こちらはユーザー対中間テーブルのリレーション
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #こちらはユーザー対ユーザーのリレーション
  has_many :following, through: :active_relationships, source: :followed

  has_many :followers, through: :passive_relationships, source: :follower
  
  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def follow(other_user)
  	# following << other_user
  	active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
  	active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
  	following.include?(other_user)
  end
end
