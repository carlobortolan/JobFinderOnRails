class Authentication < ActiveRecord::Base
  validates :token, presence: true, uniqueness: true
  validates :scope, presence: true, uniqueness: false
  validates :user, presence: true, uniqueness: false
  validates :expires_at, presence: true, uniqueness: false
end
