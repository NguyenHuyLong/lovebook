class CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :find_category

  def show
    @books = @category.books.paginate(page: params[:page], per_page: 20)
      .order created_at: :desc
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "flash.danger.category_not_found"
      redirect_to admins_categories_path
    end
  end
end
