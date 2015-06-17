class User < ActiveRecord::Base
  # Remember to create a migration!

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_hash, presence: true

end
