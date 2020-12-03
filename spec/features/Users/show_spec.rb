require 'rails_helper'

describe 'As a logged in user, on my dashboard' do
  before :each do
    @user = User.create(name: "Elvis", password: "test", email: 'user@email.com')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path
  end

  it 'I see a button to discover movies' do
    click_button 'Discover Movies'

    expect(current_path).to eq(discover_path)
  end

  it 'I see a friends section where I can add a friend' do
    brett = User.create(name: 'Brett', email: 'brett@email.com', password: 'brettspassword' )

    expect(@user.friends.first).to eq(nil)
    expect(page).to have_content('You currently have no friends')

    within ".friends" do
      fill_in :email, with: brett.email
      click_on 'Add Friend'
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("#{brett.name} is now your friend")

    within "#friend-#{brett.id}" do
      expect(page).to have_content(brett.name)
    end

    expect(@user.friends.first).to eq(brett)
  end

  it 'I get an error when theres no email found' do
    within ".friends" do
      fill_in :email, with: 'someone@email.com'
      click_on 'Add Friend'
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("There aren't any users with that email")
  end

  it "I can't add myself as a friend" do
    within ".friends" do
      fill_in :email, with: @user.email
      click_on 'Add Friend'
    end

    expect(page).to have_content("That's your own email, silly!")
  end

  it 'I can see viewing parties' do
    user_2 = User.create!(name: 'Steve', email: 'steve@email.com', password: 'password')
    movie = Movie.create(title: 'The Fifth Element', runtime: 120, api_id: 0)
    party = Party.create!(user_id: @user.id, date: '01/01/2020', start_time: '07:00', movie_id: movie.id)
    party = @user.parties.create!(date: '01/01/2020', start_time: '07:00', movie_id: movie.id)
    movie_2 = Movie.create(title: 'Happy Dragon', runtime: 120, api_id: 0)
    party_2 = user_2.parties.create!(date: '03/11/2020', start_time: '11:00', movie_id: movie_2.id)
    # guest = Guest.create!(party_id: party_2.id, user_id: @user.id)
    friendship_1 = Friendship.create!(user: @user, friend: user_2)
    friendship_2 = Friendship.create!(user: user_2, friend: @user)

    expect(page).to have_content('Viewing Parties')
require "pry"; binding.pry
    # within "#party-#{@user.id}" do
      expect(page).to have_content(movie.title)
      expect(page).to have_content(party.date)
      expect(page).to have_content(party.start_time)
      expect(page).to have_content("Hosting")
    # end

    # within "#party-#{party_2.id}" do
      expect(page).to have_content(movie_2.title)
      expect(page).to have_content(party_2.date)
      expect(page).to have_content(party_2.start_time)
      expect(page).to have_content("Invited")
    # end
  end
end
