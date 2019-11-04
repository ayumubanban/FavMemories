class User < ApplicationRecord
  has_secure_password  # * passwordがあるかどうか自動的にチェックしてくれる

  validates :name, { presence: true, length: { maximum: 20 } }
  validates :email, { presence: true, uniqueness: true }
  # validates :password, { presence: true }

  # * 投稿
  has_many :posts, dependent: :destroy

  # * いいね
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  # * コメント
  has_many :comments, dependent: :destroy

  # * フォロー一覧
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower

  # * フォロワー一覧
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following

  # * プロフィール画像
  has_one_attached :avatar

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      # * 名前の変更を反映
      if user.name == nil
        user.name = auth.info.name
      end
      user.email = auth.info.email
      user.password = SecureRandom.urlsafe_base64(n=6)
      user.image = auth.info.image
      user.oauth_token = auth.credentials.token
      if auth.credentials.expires_at
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      end
      return user
    end
  end


  # * user has many postsっていう1対多の関係を自分らでメソッド定義して表してる
  # def posts
  #   return Post.where(user_id: self.id)
  # end
end
