class Application < ApplicationRecord
  belongs_to :job

  validates :applicant_id, presence: true
  validates :job_id, presence: true
  validates :application_text, presence: true, length: { minimum: 10 }

  def get_name
    AccountService.new.get_account_name(applicant_id.to_i)
  end
end
