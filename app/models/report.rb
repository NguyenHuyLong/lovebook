class Report < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :book_name, presence: true
  validates :book_author, presence: true
end
