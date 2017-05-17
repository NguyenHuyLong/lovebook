class ReviewsController < ApplicationController
  before_action :logged_in_user
  before_action :find_review, only: [:edit, :update, :destroy, :show]
  before_action :find_book, only: [:edit, :update]

  def new
    @review = Review.new
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:danger] = t "flash.danger.book_not_found"
      redirect_to books_path
    end
  end

  def create
    @review = current_user.reviews.new review_params
    if @review.save
      book_rating
      @activity = current_user.activities.create review: @review, book: @review.book
      flash[:success] = t "flash.success.create_review"
      redirect_to book_path @review.book_id
    else
      @book = Book.find_by id: params[:review][:book_id]
      render :new
    end
  end

  def show
    @comment = Comment.new
    @report = Report.new
  end

  def edit
  end

  def update
    if @review.update_attributes review_params
      book_rating
      flash[:success] = t "user.profile_updated"
      redirect_to @review.book
    else
      render :edit
    end
  end

  def destroy
    @reviews = @review.book.reviews
    unless @review.destroy
      flash[:danger] = t "flash.danger.cannot_delete_review"
    end
    respond_to do |format|
      format.html {redirect_to book_path @review.book}
      format.js {}
    end
  end

  private
  def review_params
    params.require(:review).permit :rating, :content, :book_id, :user_id
  end

  def find_review
    @review = Review.find_by id: params[:id]
    unless @review
      flash[:danger] = t "flash.danger.review_not_found"
      redirect_to books_path
    end
  end

  def find_book
    @book = @review.book
    unless @book
      flash[:danger] = t "flash.danger.book_not_found"
      redirect_to books_path
    end
  end

  def book_rating
    rating = 0.00
    @review.book.reviews.each do |review|
      rating += review.rating
    end

    book_rating = rating/(@review.book.reviews.count)

    @review.book.update_attributes rating: book_rating
  end
end
