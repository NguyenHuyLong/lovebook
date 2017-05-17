module RequestConcern
  def find_request
    @request = Request.find_by id: params[:id]
    unless @request
      flash[:danger] = t "flash.danger.request_not_found"
      redirect_to requests_path
    end
  end
end
