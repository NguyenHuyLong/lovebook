class Admins::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin

  def destroy
    @user = User.find_by id: params[:id]
    if @user.destroy
      flash[:success] = t "flash.success.delete_user"
    else
      flash[:danger] = t "flash.danger.delete_user"
    end
    redirect_to users_path
  end
end
