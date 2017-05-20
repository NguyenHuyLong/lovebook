class Request < ApplicationRecord
  belongs_to :user

  enum status: {pending: 0, approve: 1, reject: 2}

  validates :book_name, presence: true
  validates :book_author, presence: true
end
