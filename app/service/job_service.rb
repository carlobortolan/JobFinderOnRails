# frozen_string_literal: true

class JobService
  def initialize
    @job_repository = JobRepository.new
  end

  def add_job(job)
    @job_repository.add_job(job)
  end

  def find_job(id)
    @job_repository.find_job(id)
  end

  def find_all_jobs
    @job_repository.find_all(job)
  end

  def match_jobs(prefiltered_jobs, query_params)
    FeedGenerator.initialize_feed(prefiltered_jobs, query_params)
  end

  def delete_job(id)
    @job_repository.delete_job(id)
  end
end
