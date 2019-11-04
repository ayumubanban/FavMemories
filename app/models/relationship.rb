class Relationship < ApplicationRecord
  # * Relationship belongs_to following(user).
  belongs_to :following, class_name: "User"
  # * Relationship belongs_to follower(user).
  belongs_to :follower, class_name: "User"

  validates :following_id, {presence: true}
  validates :follower_id, {presence: true}
  validates_uniqueness_of :follower_id, scope: :following_id
end
