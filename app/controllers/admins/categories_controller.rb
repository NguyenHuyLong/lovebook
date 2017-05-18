class Admins::CategoriesController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_category, except: [:index, :create]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
      .order created_at: :desc
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      @categories = Category.all
      redirect_to admins_categories_path
    else
      render :new
    end
  end

  def show
    @books = @category.books.paginate(page: params[:page], per_page: 20)
      .order created_at: :desc
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "flash.success.update_category"
    else
      flash[:danger] = t "flash.danger.category_not_update"
    end
    redirect_to admins_categories_path
  end

  def destroy
    @category.destroy
    flash[:success] = t "flash.success.delete_category"
    redirect_to admins_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "flash.danger.category_not_found"
      redirect_to admins_categories_path
    end
  end
end
