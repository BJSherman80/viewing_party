require 'rails_helper'

RSpec.describe "User registration form" do
  it "creates new user" do

    visit "/registration"

    email = "user@email.com"
    password = "test"
    name = "Elvis"

    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on "Register"
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Welcome, #{name}!")
    expect(page).to have_button("Logout")
  end

  it 'see flash for when email exists' do
    user = User.create(name: "Elvis", password: "test", email: 'user@email.com')

    visit "/registration"

    password = "test"
    name = "Burt"

    fill_in :name, with: name
    fill_in :email, with: user.email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    click_on "Register"
    expect(current_path).to eq('/registration')
    expect(page).to have_content("Email has already been taken")
  end

  it 'see flash for when passwords dont match' do

    visit "/registration"
    email = 'user@email.com'
    password = "test"
    name = "Burt"

    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: "wrong password"
    click_on "Register"
    expect(current_path).to eq('/registration')
    expect(page).to have_content("Password and Password Confirmation fields did not match.")
  end

  it 'see flash for when fields are missing' do

    visit "/registration"
    email = 'user@email.com'
    password = "test"
    name = "Burt"

    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    click_on "Register"
    expect(current_path).to eq('/registration')
    expect(page).to have_content("You are missing required fields.")

    fill_in :name, with: name
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    click_on "Register"
    expect(current_path).to eq('/registration')
    expect(page).to have_content("You are missing required fields.")

    fill_in :email, with: email
    fill_in :name, with: name
    click_on "Register"
    expect(current_path).to eq('/registration')
    expect(page).to have_content("You are missing required fields.")
  end
end
