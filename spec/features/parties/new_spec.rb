require 'rails_helper'

describe 'New viewing party' do
  it 'See a form to add party details and create a party' do
    VCR.use_cassette("Movie_Index_Page/can_search_by_movie_title", allow_playback_repeats: true, :record => :new_episodes) do
      user = User.create!(name: "Elvis", password: "test", email: 'user@email.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit discover_path

      fill_in :search, with: "Happy Gilmore"
      click_on "Find Movies"

      click_link "Happy Gilmore"
      click_button "Create Viewing Party for Movie"

      expect(current_path).to eq(new_party_path)
      expect(page).to have_content("Happy Gilmore")
      expect(page).to have_content("Party duration")
      expect(page).to have_content("Date")
      expect(page).to have_content("Start time")
      fill_in :party_duration, with: 120
      fill_in :date, with: "12/05/2020"
      fill_in :start_time, with: "7:00"

      click_on "Create Party"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Your viewing party has been created')
    end
  end

  it "can not create a party with empty fields" do
    VCR.use_cassette("Movie_Index_Page/can_search_by_movie_title", allow_playback_repeats: true, :record => :new_episodes) do
      user = User.create!(name: "Elvis", password: "test", email: 'user@email.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit discover_path

      fill_in :search, with: "Happy Gilmore"
      click_on "Find Movies"

      click_link "Happy Gilmore"
      click_button "Create Viewing Party for Movie"

      expect(current_path).to eq(new_party_path)
      expect(page).to have_content("Happy Gilmore")
      expect(page).to have_content("Party duration")
      expect(page).to have_content("Date")
      expect(page).to have_content("Start time")
      fill_in :party_duration, with: 160
      fill_in :date, with: ""
      fill_in :start_time, with: "7:00"

      click_on "Create Party"

      expect(current_path).to eq(parties_path)
      expect(page).to have_content('Missing fields. Please try again.')
    end
  end

  it "cannot make a party duration shorter than movie length time" do
    VCR.use_cassette("Movie_Index_Page/can_search_by_movie_title", allow_playback_repeats: true, :record => :new_episodes) do
      user = User.create!(name: "Elvis", password: "test", email: 'user@email.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit discover_path

      fill_in :search, with: "Happy Gilmore"
      click_on "Find Movies"

      click_link "Happy Gilmore"
      click_button "Create Viewing Party for Movie"

      expect(current_path).to eq(new_party_path)
      expect(page).to have_content("Happy Gilmore")
      expect(page).to have_content("Party duration")
      expect(page).to have_content("Date")
      expect(page).to have_content("Start time")
      fill_in :party_duration, with: 20
      fill_in :date, with: "12/05/2020"
      fill_in :start_time, with: "7:00"

      click_on "Create Party"

      expect(current_path).to eq(parties_path)
      expect(page).to have_content('Party duration cannot by shorter than movie length time.')
    end
  end

  it "can see/click checkboxes next to friends if friends exist" do
    VCR.use_cassette("Movie_Index_Page/can_search_by_movie_title", allow_playback_repeats: true, :record => :new_episodes) do
      # user = User.create!(name: "Elvis", password: "test", email: 'user@email.com')
      jake = User.create!(name: 'Jake', email: 'jake@email.com', password: 'jake')
      dani = User.create!(name: 'Dani', email: 'dani@email.com', password: 'dani')
      brett = User.create!(name: 'Brett', email: 'brett@email.com', password: 'brett')

      friendship1 = Friendship.create(friend: brett, user: dani)
      friendship2 = Friendship.create(friend: dani, user: brett)

      friendship3 = Friendship.create(friend: jake, user: brett)
      friendship4 = Friendship.create(friend: brett, user: jake)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(brett)
      visit discover_path

      fill_in :search, with: "Happy Gilmore"
      click_on "Find Movies"

      click_link "Happy Gilmore"
      click_button "Create Viewing Party for Movie"

      expect(current_path).to eq(new_party_path)
      expect(page).to have_content("Happy Gilmore")
      expect(page).to have_content("Party duration")
      expect(page).to have_content("Date")
      expect(page).to have_content("Start time")
      fill_in :party_duration, with: 160
      fill_in :date, with: "12/05/2020"
      fill_in :start_time, with: "7:00"

      expect(page).to have_content(jake.name)
      expect(page).to have_content(dani.name)

      check("#{jake.name}")
      check("#{dani.name}")

      click_on "Create Party"

      party = Party.last

      expect(party.guests).to eq([jake, dani])
      expect(current_path).to eq(dashboard_path)
    end
  end

  it "An invited friend sees party on their dashboard" do
    jake = User.create!(name: 'Jake', email: 'jake@email.com', password: 'jake')
    brett = User.create!(name: 'Brett', email: 'brett@email.com', password: 'brett')
    jake_movie = Movie.create!(title: "The Fifth Element" , runtime: 117 , api_id: 400)
    friendship = Friendship.create!(friend: brett, user: jake)
    jake_party = jake.parties.create!(date: "12/31/1999", start_time: "11:59", party_duration: 120, movie_id: jake_movie.id)
    guest = Guest.create!(party_id: jake_party.id, guest_id: brett.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(brett)

    visit dashboard_path
save_and_open_page
    expect(page).to have_content(jake_movie.title)
    expect(page).to have_content(jake_party.date)
    expect(page).to have_content(jake_party.start_time)
    expect(page).to have_content("2 hr 0 min")
    expect(page).to have_content("Invited")
  end
end
