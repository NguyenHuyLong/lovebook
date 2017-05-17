class Book < ApplicationRecord
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :favorite_books, dependent: :destroy
  has_many :activities, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :author, presence: true
  validates :description, presence: true
  validates :number_of_pages, presence: true
  validates :category, presence: true
  validates :publish_date, presence: true

  scope :search_book_by_search_params, -> search_param do
    where "title LIKE ? OR author LIKE ?",
      "%#{search_param}%", "%#{search_param}%" if search_param.present?
  end
  scope :order_by_id, -> {order id: :desc}

  class << self
    def search search_param, category_id
      if category_id.present?
        Category.find_by(id: category_id).books
      else
        all
      end.search_book_by_search_params(search_param).order_by_id
    end
  end
end
