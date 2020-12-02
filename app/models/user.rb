class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, require: true
  validates_presence_of :password, require: true
  validates :password, confirmation: { case_sensitive: true }
  validates :email, uniqueness: true, presence: true


  def duplicate_email?
    User.pluck(:email).include?(email)
  end
end
