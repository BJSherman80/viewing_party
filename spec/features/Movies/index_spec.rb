require 'rails_helper'

RSpec.describe 'Movie Index Page' do
  it "list top 40 Movies" do
    user = User.create!(name: "Elvis", password: "test", email: 'user@email.com')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/discover'

    click_on 'Find Top Rated Movies'
    expect(page).to have_button('Find Top Rated Movies')
    expect(page).to have_field('Search by movie title')
    expect(page).to have_button('Find Movies')
    expect(current_path).to eq(movies_path)
    expect(page).to have_css('.movie')

    within(first('.movie')) do
      expect(page).to have_css('.title')
      expect(page).to have_css('.vote_average')
    end
  end

  it "can search by movie title" do
    user = User.create!(name: "Elvis", password: "test", email: 'user@email.com')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/discover'

    fill_in :search, with: "Happy"
    click_on 'Find Movie'

    expect(page).to have_button('Find Top Rated Movies')
    expect(page).to have_field('Search by movie title')
    expect(page).to have_button('Find Movies')
    expect(current_path).to eq(movies_path)
    expect(page).to have_css('.movie')

    within(first('.movie')) do
      expect(page).to have_content("Happy")
      expect(page).to have_css('.title')
      expect(page).to have_css('.vote_average')
    end
  end

  it 'can see upcoming movies' do
    user = User.create!(name: "Elvis", password: "test", email: 'user@email.com')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit discover_path

    click_button "Movies Playing Now"

    expect(page).to have_content("Release Date")
  end
end
