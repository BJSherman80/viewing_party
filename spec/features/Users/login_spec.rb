require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(name: "Elvis", password: "test", email: 'user@email.com')
    visit '/'
    fill_in :email, with: user.email
    fill_in :password, with: user.password


    click_on "Log In"

    expect(current_path).to eq('/dashboard')

    expect(page).to have_content("Welcome, #{user.name}")
    expect(page).to have_button("Logout")
  end

  it "cannot log in with bad credentials" do
    user = User.create(name: "Elvis", password: "test", email: 'user@email.com')
    visit '/'
    fill_in :email, with: user.email
    fill_in :password, with: "incorrect password"

    click_on "Log In"

    expect(current_path).to eq('/')

    expect(page).to have_content("Sorry, your credentials are bad.")

    fill_in :email, with: user.email

    click_on "Log In"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Sorry, your credentials are bad.")

    fill_in :email, with: "burt"
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  it "I can't visit the dashboard without being logged in" do
    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('401')
    expect(page).to have_content('You are not authorized to access this page')
  end


end
