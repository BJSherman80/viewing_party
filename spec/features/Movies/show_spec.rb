require 'rails_helper'
require 'faraday'
require 'pry'

RSpec.describe 'Movies show page' do
  it 'can see movie attributes', :vcr do
    VCR.use_cassette("Movie_Index_Page/can_search_by_movie_title") do
      user = User.create!(name: "Elvis", password: "test", email: 'user@email.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit discover_path

      fill_in :search, with: "Happy Gilmore"
      click_on "Find Movies"

      click_link "Happy Gilmore"
      expect(page).to have_button("Create Viewing Party for Movie")
      expect(page).to have_content("Happy Gilmore")
      expect(page).to have_content("Vote Average: 6.6")
      expect(page).to have_content("Runtime: 1 hr 32 min")
      expect(page).to have_content("Genre(s): Comedy")
      expect(page).to have_content("Summary: Failed hockey player-turned-golf whiz Happy Gilmore -- whose unconventional approach and antics on the grass courts the ire of rival Shooter McGavin -- is determined to win a PGA tournament so he can save his")
    end
  end
  it 'can see a movies top 10 actors' do
    
  end
end
