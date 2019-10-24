class User < ApplicationRecord
  has_secure_password  # * passwordがあるかどうか自動的にチェックしてくれる

  validates :name, { presence: true }
  validates :email, { presence: true, uniqueness: true }
  # validates :password, { presence: true }

  # * フォロー一覧
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  # * フォロワー一覧
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  # * プロフィール画像
  has_one_attached :avatar

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end


  # * user has many postsっていう1対多の関係を自分らでメソッド定義して表してる
  def posts
    return Post.where(user_id: self.id)
  end
end
