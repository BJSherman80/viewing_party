require 'rails_helper'

describe 'As a logged in user, on my dashboard' do
  before :each do
    @user = User.create(name: "Elvis", password: "test", email: 'user@email.com')
    @movie = Movie.create(title: 'The Fifth Element', runtime: 120, api_id: 0)
    @party = Party.create!(user_id: @user.id, date: '01/01/2020', start_time: '07:00', movie_id: @movie.id, party_duration: 120)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'I see a button to discover movies' do
    visit dashboard_path

    click_button 'Discover Movies'

    expect(current_path).to eq(discover_path)
  end

  it 'I see a friends section where I can add a friend' do
    visit dashboard_path

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
    visit dashboard_path

    within ".friends" do
      fill_in :email, with: 'someone@email.com'
      click_on 'Add Friend'
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("There aren't any users with that email")
  end

  it "I can't add myself as a friend" do
    visit dashboard_path

    within ".friends" do
      fill_in :email, with: @user.email
      click_on 'Add Friend'
    end

    expect(page).to have_content("That's your own email, silly!")
  end

  it 'I can see viewing parties' do
    visit dashboard_path

    expect(page).to have_content('Viewing Parties')

    within "#party-#{@party.id}" do
      expect(page).to have_content(@movie.title)
      expect(page).to have_content(@party.date)
      expect(page).to have_content(@party.start_time)
      expect(page).to have_content("Hosting")
    end
  end
end
