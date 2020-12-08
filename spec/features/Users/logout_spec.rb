require 'rails_helper'

describe 'As a user' do
  it 'I can log out' do
    user = User.create(name: 'Elvis', email: 'email@email.com', password: 'password')
    visit root_path
    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_link('Logout')

    click_link "Logout"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You've been successfully logged out")
    expect(page).to have_button("Log In")
  end
end
