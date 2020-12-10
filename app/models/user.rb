class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :password, presence: true
  validates :password, confirmation: { case_sensitive: true }
  validates :email, uniqueness: true, presence: true

  has_many :parties, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  def invited_to_parties
    Party.joins(:guests).where('guests.friend_id = ? ', id)
  end

  def all_parties
    parties + invited_to_parties
  end
end
