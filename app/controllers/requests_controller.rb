class RequestsController < ApplicationController
  include RequestConcern

  before_action :logged_in_user
  before_action :find_request, only: [:edit, :update, :destroy]

  def index
    @requests = current_user.requests
  end

  def new
    @request = Request.new
  end

  def create
    @request = current_user.requests.new request_params
    if @request.save
      flash[:success] = t "flash.success.send_request"
      redirect_to requests_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @request.update_attributes request_params
      flash[:success] = "Cập nhật thành công"
      redirect_to requests_path
    else
      render :edit
    end
  end

  def destroy
    unless @request.destroy
      flash[:danger] = t "flash.danger.cannot_delete_request"
    end
    respond_to do |format|
      format.html {redirect_to requests_path}
      format.js {}
    end
  end

  private
  def request_params
    params.require(:request).permit :book_name, :book_author
  end
end
