class Relationship < ApplicationRecord

  validates :following_id, {presence: true}
  validates :follower_id, {presence: true}

  # * Relationship belongs_to following(user).
  belongs_to :following, class_name: "User"
  # * Relationship belongs_to follower(user).
  belongs_to :follower, class_name: "User"
end
