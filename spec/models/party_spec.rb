require 'rails_helper'

describe Party, type: :model do
  describe 'relationships' do
    it { should belong_to :movie }
    it { should belong_to :user }
    it { should have_many :guests }
  end

  describe 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :movie_id }
    it { should validate_presence_of :party_duration }
  end

  describe 'instance_methods' do
    it '#host_status' do
      jake = User.create!(name: 'Jake', email: 'jake@email.com', password: 'jake')
      brett = User.create!(name: 'Brett', email: 'brett@email.com', password: 'brett')
      jake_movie = Movie.create!(title: "The Fifth Element" , runtime: 117 , api_id: 400)
      brett_movie = Movie.create!(title: "Candy Land" , runtime: 105 , api_id: 600)
      friendship = Friendship.create!(friend: brett, user: jake)
      friendship = Friendship.create!(friend: jake, user: brett)
      jake_party = jake.parties.create!(date: "12/31/1999", start_time: "11:59", party_duration: 120, movie_id: jake_movie.id)
      lit_party = brett.parties.create!(date: "1/31/1939", start_time: "3:59", party_duration: 120, movie_id: brett_movie.id)
      guest = Guest.create!(party_id: jake_party.id, friend_id: brett.id)
      guest = Guest.create!(party_id: lit_party.id, friend_id: jake.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(jake)

      expect(jake_party.host_status(jake)).to eq("Hosting")
      expect(lit_party.host_status(jake)).to eq("Invited")
    end
  end
end
