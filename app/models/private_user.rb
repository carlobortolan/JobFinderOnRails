class PrivateUser < User
  validates :private_attr, presence: true
end
