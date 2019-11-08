class Post < ApplicationRecord
  validates :content, presence: true
  validates :user_id, { presence: true }

  # * ユーザー
  belongs_to :user

  # * いいね
  has_many :likes, dependent: :destroy

  # * コメント
  has_many :comments, dependent: :destroy

  # * プロフィール画像
  has_one_attached :photo

  # * ツイートがいいねされているかどうか
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end


end
