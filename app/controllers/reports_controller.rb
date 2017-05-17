class ReportsController < ApplicationController
  def create
    @report = current_user.reports.new report_params
    if @report.save
      flash[:success] = "Report successfull"
      redirect_to @report.review
    end
  end

  private
  def report_params
    params.require(:report).permit :review_id, :content, :reported_user
  end
end
