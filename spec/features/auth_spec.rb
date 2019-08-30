require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  background { visit new_user_url }

  scenario 'has a new user page' do
      expect(page).to have_content 'Signup Page'
  end

  feature 'signing up a user' do
    scenario 'shows email on the #show page after signup' do
      fill_in 'email', with: 'test@example.com'
      fill_in 'password', with: 'password1'
      click_on('Create User')
      expect(page).to have_content('test@example.com')
    end
  end
end

feature 'logging in' do
  given(:user_in_db) { FactoryBot.create(:user_in_db, password: 'password1') }

  scenario 'shows username on the homepage after login' do
    visit new_session_url
    fill_in 'email', with: user_in_db.email
    fill_in 'password', with: user_in_db.password
    click_on 'Login User'
    expect(page).to have_current_path(user_path(User.find_by email: 'test@example.com'))
    expect(page).to have_content('test@example.com')
    expect(page).to have_content('Login successful!')
  end
end

feature 'logging out' do
  given(:user_in_db) { FactoryBot.create(:user_in_db, password: 'password1')}

  scenario 'begins with a logged out state' do
    visit root_url
    expect(page).to have_selector('header a', text: "Sign up")
    expect(page).to have_selector('header a', text: "Login")
  end

  scenario 'doesn\'t show email on the homepage after logout' do
    visit new_session_url
    fill_in 'email', with: user_in_db.email
    fill_in 'password', with: user_in_db.password
    click_on 'Login User'
    click_on 'Log Out'
    expect(page).to have_no_selector('header a', text: user_in_db.email )
  end
end