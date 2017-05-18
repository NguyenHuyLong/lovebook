class Admins::BooksController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_book, except: [:index, :new, :create]
  before_action :find_request, only: :new

  def index
    @books = Book.search(params[:search_param], params[:category_id])
      .paginate page: params[:page], per_page: 20
    @categories = Category.all
  end

  def new
    @book = Book.new
    @categories = Category.all.order name: :asc
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "flash.success.book_create"
      redirect_to admins_book_path @book
    else
      @categories = Category.all.order name: :asc
      render :new
    end
  end

  def show
  end

  def edit
    @categories = Category.all.order name: :asc
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "flash.success.book_update"
    else
      flash[:danger] = t "flash.danger.book_not_update"
    end
    redirect_to admins_book_path @book
  end

  def destroy
    @book.destroy
    flash[:danger] = t "flash.success.book_delete"
    redirect_to admins_books_path
  end

  private
  def book_params
    params.require(:book).permit :title, :author, :description, :publish_date,
      :number_of_pages, :image, :category_id
  end

  def find_book
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:danger] = t "flash.danger.book_not_found"
      redirect_to admins_books_path
    end
  end

  def find_request
    @request = Request.find_by id: params[:request_id]
  end
end
