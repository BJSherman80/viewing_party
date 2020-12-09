require 'rails_helper'

describe Guest, type: :model do
  describe 'relationships' do
    it { should belong_to :party }
    it { should belong_to :friend }
  end

  describe 'class methods' do
    it '#guest_to_user' do
      jake = User.create!(name: 'Jake', email: 'jake@email.com', password: 'jake')
      dani = User.create!(name: 'Dani', email: 'dani@email.com', password: 'dani')
      friendship = Friendship.create!(friend: dani, user: jake)
      jake_movie = Movie.create!(title: "The Fifth Element" , runtime: 117 , api_id: 400)
      jake_party = jake.parties.create!(date: "12/31/1999", start_time: "11:59", party_duration: 120, movie_id: jake_movie.id)
      guest = Guest.create!(party_id: jake_party.id, friend_id: dani.id)

      expect(Guest.party_guests(jake_party.guests)).to eq([dani])
    end
  end



end
