class User < ApplicationRecord
  has_secure_password  # * passwordがあるかどうか自動的にチェックしてくれる
  # * allow_nilによって、ユーザー編集時にpasswordを求められなくて済む
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :name, { presence: true, length: { maximum: 20 } }
  validates :email, { presence: true, uniqueness: true }
  validates :intro, length: { maximum: 150 }

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
end
