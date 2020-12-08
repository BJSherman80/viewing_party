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
      fill_in :party_duration, with: ''
      fill_in :date, with: "12/05/2020"
      fill_in :start_time, with: "7:00"

      click_on "Create Party"

      expect(current_path).to eq(parties_path)
      expect(page).to have_content('Missing fields. Please try again.')
    end
  end
end
