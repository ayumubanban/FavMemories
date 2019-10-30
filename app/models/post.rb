class Post < ApplicationRecord
  validates :content, { presence: true, length: { maximum: 140 } }
  validates :user_id, { presence: true }

  # * ユーザー
  belongs_to :user

  # * いいね
  has_many :likes, dependent: :destroy

  # * コメント
  has_many :comments, dependent: :destroy

  # def user
  #   # * インスタンスメソッド内で、selfはそのインスタンス自身を指す
  #   # * post belongs to userっていう従属関係を自分らでメソッド定義して表してる
  #   return User.find_by(id: self.user_id)
  # end

  # * ツイートがいいねされているかどうか
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end


end
