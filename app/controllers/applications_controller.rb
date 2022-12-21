class ApplicationsController < ApplicationController
  http_basic_authenticate_with name: "cb", password: "5503", only: :destroy
  attr_accessor(:application_service)

  def initialize
    puts "TTT"
    @application_service = ApplicationService.new(nil, nil)
  end

  def new
    @application = Application.new
  end

  def create
    @job = Job.find(params[:job_id])
    begin
      @application_service.add_application(params[:job_id].to_i, application_params[:applicant_id].to_i, application_params[:application_text], application_params[:application_documents])
      redirect_to job_path(@job)
    rescue
      render :duplicate, status: :conflict
    end
  end

  def destroy
    @job = Job.find(params[:job_id])
    @application = @job.applications.find(params[:job_id])
    @application.destroy
    redirect_to job_path(@job), status: :see_other
  end

  private

  def application_params
    params.require(:application).permit(:applicant_id, :application_text, :application_documents)
  end
end
