class ApplicationsController < ApplicationController
  layout 'standard'
  http_basic_authenticate_with name: "cb", password: "1", except: :index

  attr_accessor(:application_service, :user_service)

  def initialize
    @application_service = ApplicationService.new(nil, nil)
    @user_service = UserService.new
  end

  def index
    @job = Job.find(params[:job_id])
    @applications = @job.applications.all
  end

  def show
    @job = Job.find(params[:job_id])
    puts "TEST"
    puts params
    puts "TEST"
    puts "TEST"
    @application = @job.applications.find_by_sql("SELECT * FROM applications a WHERE a.applicant_id = #{params[:id]} and a.job_id = #{params[:job_id]}")
  end

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
    @application = @job.applications.find(params[:applicant_id])
    @application.destroy
    redirect_to job_path(@job), status: :see_other
  end

  def accept
    @application_service.accept(params[:job_id].to_i, params[:application_id].to_i, "ACCEPTED")
    puts "ACCEPT"
    redirect_to job_path(Job.find_by_job_id(params[:job_id])), status: :see_other
  end

  def reject
    puts "param = #{params}"
    @application_service.reject(params[:job_id].to_i, params[:application_id].to_i, "REJECTED")
    puts "REJECT"
    redirect_to job_applications_path(params[:job_id])
  end

  def reject_all
    puts "REJECT ALL"
    puts "params = #{params}"
    @application_service.reject_all(params[:job_id].to_i, "REJECTED")
    redirect_to job_path(Job.find_by_job_id(params[:job_id])), status: :see_other
    #    redirect_to job_path(@job), status: :see_other
  end

  private

  def application_params
    params.require(:application).permit(:applicant_id, :application_text, :application_documents)
  end
end
