module BooksHelper
  def book_image book
    if book.image.blank?
      image_tag "book.jpg", size: Settings.book_size
    else
      image_tag book.image.thumb.to_s
    end
  end

  def book_image_show book
    if book.image.blank?
      image_tag "book.jpg", size: Settings.book_size_show
    else
      image_tag book.image.book_size.to_s
    end
  end

  def publish_date book
    unless book.publish_date.blank?
      l book.publish_date
    end
  end

  def favourite_book_image book
    if book.image.blank?
      image_tag "book.jpg", size: Settings.favourite_book_image
    else
      image_tag book.image.favourite_book.to_s
    end
  end

  def book_image_review book
    if book.image.blank?
      image_tag "book.jpg", size: Settings.book_size_review
    else
      image_tag book.image.review_book.to_s
    end
  end
end
