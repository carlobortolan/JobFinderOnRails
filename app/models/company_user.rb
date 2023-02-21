class CompanyUser < User
  validates :company_name, presence: true

end
