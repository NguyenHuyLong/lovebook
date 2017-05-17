class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :content, presence: true
  validates :rating, presence: true
end
