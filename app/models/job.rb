class Job < ApplicationRecord
  include Visible
  has_many :applications, dependent: :delete_all

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :start_slot, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

  def start_search(prefiltered, my_args)
    puts "STARTIGN"
  end

  def to_s
    "#{title  }"
  end
end
