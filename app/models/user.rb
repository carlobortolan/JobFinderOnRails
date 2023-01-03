class User < ApplicationRecord
  has_secure_password

  #validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  validate :require_email
  #validates :first_name, presence: true, uniqueness: false
  validate :require_first_name
  #validates :last_name, presence: true, uniqueness: false
  validate :require_last_name

  has_many :jobs

  private

    def require_email
      if email.empty?
        errors.add :email , {"error":"ERR_BLANK", "description":"Attribute can't be blank"}
      end

      if User.where(email: email).exists?
        errors.add :email , {"error":"ERR_TAKEN", "description":"Attribute is already taken"}
      end

      if !email.match(/\A[^@\s]+@[^@\s]+\z/)
        errors.add :email, {"error":"ERR_INVALID", "description":"Attribute is malformed"}
      end
    end

    def require_first_name
      if first_name.empty?
        errors.add :first_name , {"error":"ERR_BLANK", "description":"Attribute can't be blank"}
      end
    end

    def require_last_name
      if last_name.empty?
        errors.add :last_name , {"error":"ERR_BLANK", "description":"Attribute can't be blank"}
      end
    end
end