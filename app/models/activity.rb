class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :review
  belongs_to :book

  scope :order_by_created_at, -> {order created_at: :desc}
  scope :feeds, -> id {where("user_id IN
    (SELECT followed_id FROM relationships WHERE follower_id = :user_id)
    OR user_id = :user_id", user_id: id)}
end
