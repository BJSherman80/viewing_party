require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'relationships' do
    it { should have_many :friendships }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many :parties }
  end

  describe 'instance methods' do
    before :each do
      @jake = User.create!(name: 'Jake', email: 'jake@email.com', password: 'jake')
      @brett = User.create!(name: 'Brett', email: 'brett@email.com', password: 'brett')
      @jake_movie = Movie.create!(title: "The Fifth Element" , runtime: 117 , api_id: 400)
      @brett_movie = Movie.create!(title: "Candy Land" , runtime: 105 , api_id: 600)
      @friendship = Friendship.create!(friend: @brett, user: @jake)
      @friendship = Friendship.create!(friend: @jake, user: @brett)
      @jake_party = @jake.parties.create!(date: "12/31/1999", start_time: "11:59", party_duration: 120, movie_id: @jake_movie.id)
      @lit_party = @brett.parties.create!(date: "1/31/1939", start_time: "3:59", party_duration: 120, movie_id: @brett_movie.id)
      @guest = Guest.create!(party_id: @jake_party.id, friend_id: @brett.id)
      @guest = Guest.create!(party_id: @lit_party.id, friend_id: @jake.id)

    end

    it '#invited_to_parties' do
      expect(@brett.invited_to_parties).to eq([@jake_party])
    end

    it '#all_parties' do
      expect(@brett.all_parties.sort).to eq([@lit_party, @jake_party].sort)
    end

    end

end
