require_relative '../../lib/feed_generator.rb'

class JobsController < ApplicationController
  layout 'standard'
  # http_basic_authenticate_with name: "cb", password: "1", except: [:index, :show]

  def initialize
    @job_service = JobService.new
  end

  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    require_user_logged_in!
    @job = Job.new
  end

  def create
    require_user_logged_in!
    @job = Job.new(job_params)
    @job.user_id = Current.user.id
    if @job.save
      @job_service.set_notification(@job[:id].to_i, @job[:user_id].to_i, params[:job][:notify].eql?("1"))
      redirect_to @job
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @job = Job.find(params[:id])
    require_user_be_owner!
  end

  def update
    @job = Job.find(params[:id])
    if require_user_be_owner!
      if @job.update(job_params)
        @job_service.edit_notification(@job[:id].to_i, @job[:user_id].to_i, params[:job][:notify].eql?("1"))
        redirect_to @job
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @job = Job.find(params[:id])
    # if require_user_be_owner!
    @job.applications.destroy
    @job.destroy
    redirect_to root_path, status: :see_other
    # end
  end

  def find
    @jobs = Job.all
  end

  def parse_inputs
    @my_args = { "longitude" => params[:longitude].to_f, "latitude" => params[:latitude].to_f, "radius" => params[:radius].to_f, "time" => Time.parse(params[:time]), "limit" => params[:limit].to_i }
    @result = FeedGenerator.initialize_feed(Job.all.as_json, @my_args)
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :start_slot, :longitude, :latitude, :status, :user_id)
  end
end
