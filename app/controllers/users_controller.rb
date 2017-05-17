class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :destroy]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @relationship = if current_user.following? @user
      current_user.active_relationships.find_by followed_id: @user.id
    else
      current_user.active_relationships.build
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "user.registered_successfully"
      redirect_to login_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "user.profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation,
      :avatar, :remove_avatar
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "flash.danger.user_not_exist"
      redirect_to root_path
    end
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @user
  end
end
