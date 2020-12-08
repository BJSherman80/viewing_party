class User < ApplicationRecord
  has_secure_password
  # validates_presence_of :name, require: true
  validates :name, presence: true
  # validates_presence_of :password, require: true
  validates :password, presence: true
  validates :password, confirmation: { case_sensitive: true }
  validates :email, uniqueness: true, presence: true

  has_many :parties, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  def duplicate_email?
    emails = User.where(email: email)
    if emails == []
      false
    else
      true
    end
  end

  def invited_to_parties
    Party.joins(:guests).where("guests.friend_id = ? ", self.id)
  end

  def all_parties
    (self.parties) + (self.invited_to_parties)
  end
end
