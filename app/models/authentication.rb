class Authentication < ActiveRecord::Base
  validates :token, presence: true, uniqueness: false
  validates :scope, presence: true, uniqueness: false
  validates :user, presence: true, uniqueness: true
  validates :expires_at, presence: true, uniqueness: false
  validates :issuer, presence: true, uniqueness: false
end
