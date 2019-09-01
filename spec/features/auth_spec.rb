require 'spec_helper'
require 'rails_helper'
require './spec/support/auth_features_helper'

include AuthFeaturesHelper

feature 'the signup process' do
  given(:user_in_db) { FactoryBot.create(:user_in_db) }

  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Signup Page'
  end

  feature 'signing up a user' do
    scenario 'shows email on the #show page after signup' do
      sign_up_as("test@example.com")
      expect(page).to have_content('test@example.com')
    end
  end
end

feature 'logging in' do
  given(:user_in_db) { FactoryBot.create(:user_in_db) }

  scenario 'shows username on the homepage after login' do
    login_as(user_in_db)
    expect(page).to have_current_path(user_path(User.find_by email: 'test@example.com'))
    expect(page).to have_content('test@example.com')
    expect(page).to have_content('Login successful!')
  end
end

feature 'logging out' do
  given(:user_in_db) { FactoryBot.create(:user_in_db) }

  scenario 'begins with a logged out state' do
    visit root_url
    expect(page).to have_selector('header a', text: "Sign up")
    expect(page).to have_selector('header a', text: "Login")
  end

  scenario 'doesn\'t show email on the homepage after logout' do
    login_as(user_in_db)
    click_on 'Log Out'
    expect(page).not_to have_selector('header a', text: user_in_db.email )
  end
end