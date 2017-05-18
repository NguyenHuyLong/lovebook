class BooksController < ApplicationController
  def index
    @categories = Category.all
    @books = Book.search(params[:search_param], params[:category_id])
      .paginate page: params[:page], per_page: 20
  end

  def show
    @book = Book.find_by id: params[:id]
    if @book
      @reviews = @book.reviews.order(created_at: :desc)
    else
      flash[:danger] = t "flash.danger.book_not_found"
      redirect_to books_path
    end

    if logged_in?
      @favorite_book = if current_user.favorite_books.find_by book_id: @book.id
        current_user.favorite_books.find_by book_id: @book.id
      else
        current_user.favorite_books.build
      end
      @comment = current_user.comments.new
    end
  end
end
