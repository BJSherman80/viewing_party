class Guest < ApplicationRecord
  belongs_to :party
  belongs_to :friend, class_name: 'User'

  def self.party_guests(guests)
    guests.map { |guest| User.find_by(id: guest.friend_id) }
  end
end
