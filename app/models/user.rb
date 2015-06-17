require 'bcrypt'

class User < ActiveRecord::Base

  has_many :questions, foreign_key: "asker_id"
  has_many :answers, foreign_key: "answerer_id"
  has_many :votes, foreign_key: "voter_id"

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_hash, presence: true

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password_attempt)
    user = User.find_by(email: email)
    return user if user && user.password = password_attempt
  end

  def name
    self.first_name + " " + self.last_name
  end
end
