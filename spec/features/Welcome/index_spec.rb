require 'rails_helper'

RSpec.describe "As a visitor" do
  it "the welcome page displays a message, description, log-in link and registration link" do
    visit '/'
    expect(page).to have_content("Welcome to Viewing Party!")
    expect(page).to have_content("Viewing Party is an app")
    expect(page).to have_button("Log In")
    expect(page).to have_button("Register New User")
  end

  it "can click register link" do
    visit '/'
    expect(page).to have_button("Register New User")
    click_on "Register New User"
    expect(current_path).to eq("/registration")
  end
end
