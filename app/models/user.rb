class User < ApplicationRecord
  has_secure_password

  validates :email, presence: { "error": "ERR_BLANK", "description": "Attribute can't be blank" }, uniqueness: { "error": "ERR_TAKEN", "description": "Attribute is already taken" }, format: { with: /\A[^@\s]+@[^@\s]+\z/, "error": "ERR_INVALID", "description": "Attribute is malformed or unknown" }

  validates :first_name, presence: { "error": "ERR_BLANK", "description": "Attribute can't be blank" }, uniqueness: false

  validates :last_name, presence: { "error": "ERR_BLANK", "description": "Attribute can't be blank" }, uniqueness: false

  has_many :jobs, dependent: :delete_all
  has_many :reviews, dependent: :delete_all
=begin
  class Blocked < StandardError
  end

  class Inactive < StandardError
  end

  class MrNobody < StandardError
  end
=end
  validates :longitude, presence: false
  validates :latitude, presence: false
  validates :country_code, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :date_of_birth, presence: true
  validates :user_type, presence: false

end