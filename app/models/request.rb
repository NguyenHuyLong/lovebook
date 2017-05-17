class Request < ApplicationRecord
  belongs_to :user

  enum status: {pending: 0, approve: 1, reject: 2}
end
