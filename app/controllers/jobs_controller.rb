require_relative '../../lib/feed_generator.rb'

class JobsController < ApplicationController
  http_basic_authenticate_with name: "cb", password: "5503", except: [:index, :show]

  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to @job
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])

    if @job.update(job_params)
      redirect_to @job
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    redirect_to jobs_path, status: :see_other
  end

  def find
    @jobs = Job.all
    begin
      my_args = { "longitude" => params[:longitude].to_f, "latitude" => params[:latitude].to_f, "radius" => params[:radius].to_f, "time" => Time.parse(params[:time]), "limit" => params[:limit].to_i }
      @result = FeedGenerator.initialize_feed(@jobs.as_json, my_args)
    rescue
      # Ignored
    end
  end

  def parse_inputs
    puts "PARAMS = #{params}"
    params[:longitude].to_f
    params[:latitude].to_f
    params[:radius].to_f
    params[:time]
    params[:limit]
    my_args = { "longitude" => params[:longitude].to_f, "latitude" => params[:latitude].to_f, "radius" => params[:radius].to_f, "time" => Time.parse(params[:time]), "limit" => params[:limit].to_i }
    @result = FeedGenerator.initialize_feed(Job.all.as_json, my_args)
    puts @result
    # do your stuff with comments_from_form here
  end

  # def start_search
  #  puts " STR #{@my_args}"
  #  FeedGenerator.initialize_feed([], @my_args)
  # end

  private

  def job_params
    params.require(:job).permit(:title, :description, :start_slot, :longitude, :latitude, :status)
  end
end
