class Job < ApplicationRecord
  include Visible
  has_many :applications, dependent: :delete_all

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
end
