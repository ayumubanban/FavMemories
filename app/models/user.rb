class User < ApplicationRecord
  validates :name, { presence: true }
  validates :email, { presence: true, uniqueness: true }
  validates :password, { presence: true }

  # * user has many postsっていう1対多の関係を自分らでメソッド定義して表してる
  def posts
    return Post.where(user_id: self.id)
  end
end
