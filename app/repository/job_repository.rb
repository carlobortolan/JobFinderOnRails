# frozen_string_literal: true
# TODO: Implement JobRepository

class JobRepository

  def add_job(job)
    # ActiveRecord::Base.connection.execute("INSERT INTO jobs VALUES #{job}")
    query = "INSERT INTO jobs VALUES #{job}"
    binds = [ActiveRecord::Relation::QueryAttribute.new('job', job, ActiveRecord::Type::Job.new)]
    ApplicationRecord.connection.exec_query(query, 'SQL', binds, prepare: true)
  end

  def find_job(job_id)
    # ActiveRecord::Base.connection.execute("SELECT * FROM jobs WHERE id = #{id};")
    query = "SELECT * FROM jobs WHERE job_id = #{job_id};"
    binds = [ActiveRecord::Relation::QueryAttribute.new('job_id', job_id, ActiveRecord::Type::Integer.new)]
    ApplicationRecord.connection.exec_query(query, 'SQL', binds, prepare: true)
  end

  def find_all_jobs
    ActiveRecord::Base.connection.execute("SELECT * FROM jobs;")
  end

  def delete_job(job_id)
    query = "REMOVE * FROM jobs WHERE job_id = #{job_id};"
    binds = [ActiveRecord::Relation::QueryAttribute.new('job_id', job_id, ActiveRecord::Type::Integer.new)]
    ApplicationRecord.connection.exec_query(query, 'SQL', binds, prepare: true)
  end


end
