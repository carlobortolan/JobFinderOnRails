# frozen_string_literal: true
# Applications: {(job_id, user_id), text, status, response}
# Notifications: {(job_id, employer_id), notify}
require 'rubygems'

# @author Jan Hummel, Carlo Bortolan
# This class communicates directly with the db and sends SQL requests
class ApplicationRepository
  # attr_accessor(:client)

  # Client parameter müssen manuell angepasst werden
  def initialize
    @client = Mysql2::Client.new(host: "localhost", port: "3306", database: "masterdata_2", username: "rm_user", password: "hô[ÕiÚéjÚ¢X*t/t¢ÕeR/ü¾nõ'g'ñ¢ß«Tíwàx²\"¡jÛß´*PZÏmõ}ßX¨º*¤àÙ7ü'ÌJÌ=´Lh#M[NöèD`¿üåvã^àði®$4¦{·d3ZE~üMêr.7>þSrÖô(òúHÒDÊ]!Ä-¯.ï!òHúã¡")
  end
  def set_notification (job_id, employer_id, new_value)
    # update boolean value of notification setting
    @client.query("UPDATE notifications SET notify = '#{(new_value ? 1 : 0)}' WHERE job_id = #{job_id} AND employer_id = #{employer_id}")
    # UPDATE notifications n
    # SET n.notify = new_value,
    # WHERE n.job_id = job_id and employer_id = n.employer_id
  end

  def get_notification (job_id, employer_id)
    # get boolean value of notification setting
    @client.query("SELECT notify FROM notifications WHERE job_id = #{job_id} AND employer_id = #{employer_id}").each do |i|
      return i.values_at("notify")[0].to_s.eql? '1'
    end
    # SELECT n.notify
    # FROM notifications n
    # WHERE n.job_id = job_id and n.employer_id = employer_id
  end

  def find_employer_id (job_id)
    @client.query("SELECT account_id FROM jobs WHERE job_id = #{job_id}").each do |i|
      return i.values_at("account_id")[0]
    end
  end

  def find_account(account_id)
    @client.query("SELECT account_id, first_name, last_name, email FROM accounts WHERE account_id = #{account_id}").each do |i|
      return { :name => i.values_at("first_name")[0].to_s.concat(" #{i.values_at("last_name")[0].to_s}"), :email => i.values_at("email")[0].to_s }
    end
  end


  # @deprecated
  def remove_old_applications (date_to)
    # remove all unanswered or rejected applications for a job with a due date before date_to
    # TODO:
  end

  def create_application (job_id, account_id, text, documents)
    # create new application as Application: {(job_id, user_id), text, status, response}
    # Key: job_id, user_id
    # text & response: String
    # status: 0=unanswered), 1=accepted, -1=rejected
    @client.query("INSERT INTO applications(job_id, applicant_id, application_text, application_documents) VALUES (#{job_id}, #{account_id}, '#{text}', '#{documents}')")
    # INSERT INTO applications (job_id, user_id, text, status, response)
    # VALUES (job_id, user_id, text, 0, "");
  end

  def change_status (job_id, account_id, new_status, response)
    # change status to -1/1;
    # add response
    @client.query("UPDATE applications SET status = '#{new_status}', response = '#{response}' WHERE job_id = #{job_id} AND applicant_id = #{account_id }")
    # UPDATE applications a
    # SET a.status = new_status,
    #     a.response = response
    # WHERE a.user_id = user_id and job job_id = a.job_id
  end

  def change_status_all (job_id, account_id, new_status, response)
    # change status to -1/1;
    # add response
    @client.query("UPDATE applications SET status = '#{new_status}', response = '#{response}' WHERE job_id = #{job_id} AND applicant_id <> #{account_id }")
    # UPDATE applications a
    # SET a.status = new_status,
    #     a.response = response
    # WHERE a.user_id = user_id and job job_id = a.job_id
  end

end

# INSERT INTO users (first_name, last_name, email, date_of_birth)
# VALUES ('Carlo', 'Bortolan', 'carlo.bortolan@tum.de', '2003-05-05')

