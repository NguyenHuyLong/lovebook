class Admins::RequestsController < ApplicationController
  include RequestConcern

  before_action :logged_in_user, :verify_admin
  before_action :find_request, only: :update

  def index
    @requests = Request.all
  end

  def update
    if @request.update_attributes status: params[:status]
      redirect_to admins_requests_path
    end
  end
end
