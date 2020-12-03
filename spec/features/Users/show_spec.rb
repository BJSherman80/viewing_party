require 'rails_helper'

describe 'As a logged in user, on my dashboard' do
  before :each do
    @user = User.create(name: "Elvis", password: "test", email: 'user@email.com')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path
  end

  it 'I see a button to discover movies' do
    click_button 'Discover Movies'

    expect(current_path).to eq(discover_path)
  end

  it 'I see a friends section where I can add a friend' do
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
    within ".friends" do
      fill_in :email, with: 'someone@email.com'
      click_on 'Add Friend'
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("There aren't any users with that email")
  end

  it "I can't add myself as a friend" do
    within ".friends" do
      fill_in :email, with: @user.email
      click_on 'Add Friend'
    end

    expect(page).to have_content("That's your own email, silly!")
  end

  
end
