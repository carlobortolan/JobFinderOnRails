# frozen_string_literal: true

class JobRepository
  def initialize
    @client = Mysql2::Client.new(host: "localhost", port: "3306", database: "masterdata", username: "rm_user", password: "hô[ÕiÚéjÚ¢X*t/t¢ÕeR/ü¾nõ'g'ñ¢ß«Tíwàx²\"¡jÛß´*PZÏmõ}ßX¨º*¤àÙ7ü'ÌJÌ=´Lh#M[NöèD`¿üåvã^àði®$4¦{·d3ZE~üMêr.7>þSrÖô(òúHÒDÊ]!Ä-¯.ï!òHúã¡")
  end

  # TODO:
  def add_job(job)
    @client.query("INSERT INTO jobs VALUES #{job}")
  end

  def find_job(id)
    @client.query("SELECT * FROM jobs WHERE id = #{id};")
  end

  def find_all_jobs
    @client.query("SELECT * FROM jobs;")
  end

  def delete_job(id)
    @client.query("REMOVE * FROM jobs WHERE id = #{id};")
  end

end
