class FavoriteBooksController < ApplicationController
  before_action :find_book, only: [:create, :destroy]

  def create
    @favorite_book = current_user.favorite_books.build favorite_book_params
    @favorite_book.save
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end

  def destroy
    @favorite_book = current_user.favorite_books.find_by book_id: favorite_book_params[:book_id]
    @favorite_book.destroy
    @favorite_books = current_user.favorite_books.build
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end

  private
  def favorite_book_params
    params.require(:favorite_book).permit :book_id
  end

  def find_book
    @book = Book.find_by id: favorite_book_params[:book_id]
    unless @book
      flash[:danger] = t "flash.danger.book_not_found"
      redirect_to books_path
    end
  end
end
