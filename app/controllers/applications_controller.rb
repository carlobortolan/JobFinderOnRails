class ApplicationsController < ApplicationController
  http_basic_authenticate_with name: "cb", password: "5503", only: :destroy

  def create
    @job = Job.find(params[:job_id])
    @application = @job.applications.create(application_params)
    redirect_to job_path(@job)
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
