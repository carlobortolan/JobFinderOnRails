# frozen_string_literal: true

class JobRepository

  # TODO:
  def add_job(job)
    ActiveRecord::Base.connection.execute("INSERT INTO jobs VALUES #{job}")
  end

  def find_job(id)
    ActiveRecord::Base.connection.execute("SELECT * FROM jobs WHERE id = #{id};")
  end

  def find_all_jobs
    ActiveRecord::Base.connection.execute("SELECT * FROM jobs;")
  end

  def delete_job(id)
    ActiveRecord::Base.connection.execute("REMOVE * FROM jobs WHERE id = #{id};")
  end

end
