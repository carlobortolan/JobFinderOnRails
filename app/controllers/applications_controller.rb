class ApplicationsController < ApplicationController
  http_basic_authenticate_with name: "cb", password: "5503", only: :destroy
  attr_accessor(:application_service)

  def initialize
    @application_service = ApplicationService.new(nil, nil)
  end

  def index
    @job = Job.find(params[:job_id])
    @applications = @job.applications.all
    #@application = @job.applications.find(params[:job_id])

  end

  def show
    @job = Job.find(params[:job_id])
    @application = @job.application.find(application_params[:applicant_id])
  end

  #  http://localhost:3000/jobs/:job_id=1/applications/:job_id=1&:applicant_id=1
  def new
    @job = Job.find(params[:job_id])
    @application = Application.new
  end

  def create
    @job = Job.find(params[:job_id])
    begin
      # try block
      @application_service.add_application(params[:job_id].to_i, application_params[:applicant_id].to_i, application_params[:application_text], application_params[:application_documents])
      redirect_to job_path(@job)
    rescue # optionally: `rescue Exception`
      @applications = @job.applications.all
      redirect_to job_path(@job)
    ensure
      # will always get executed
      puts 'Always gets executed.'
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
