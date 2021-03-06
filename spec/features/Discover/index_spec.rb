require 'rails_helper'

RSpec.describe "As a User" do
  it "can see a button to discover top 40 movies" do
    user = User.create!(name: "Elvis", password: "test", email: 'user@email.com')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit discover_path

    expect(page).to have_button('Find Top Rated Movies')
  end

  it "can see form to search for movies by title" do
    user = User.create!(name: "Elvis", password: "test", email: 'user@email.com')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit discover_path

    fill_in :search, with: "Happy Gilmore"
    click_on "Find Movies"
    expect(current_path).to eq(movies_path)
  end

  it 'can see a button to find movies now playing' do
    user = User.create!(name: "Elvis", password: "test", email: 'user@email.com')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit discover_path

    click_button "Movies Playing Now"

    expect(current_path).to eq(movies_path)
  end
end
