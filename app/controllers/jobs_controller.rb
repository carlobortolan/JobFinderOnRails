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
  end

  #def start_search
  #  puts "STR #{@my_args}"
  #  FeedGenerator.initialize_feed([], @my_args)
  #end

  private

  def job_params
    params.require(:job).permit(:title, :description, :start_slot, :status)
  end
end
