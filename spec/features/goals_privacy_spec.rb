require 'rails_helper'
require './spec/support/auth_features_helper.rb'
require './spec/support/goals_features_helper.rb'

include AuthFeaturesHelper
include GoalsFeaturesHelper

feature 'goal privacy' do
  given(:user_in_db) { FactoryBot.create(:user_in_db) }
  given(:user2_in_db) { FactoryBot.create(:user2_in_db) }

  feature 'public goals' do
    scenario 'should create public goals by default' do
      login_as(user_in_db)
      create_new_goal
      expect(page).to have_selector "tr td", text: "Public"
    end

    scenario 'show public goals when logged out' do
      login_as(user_in_db)
      create_new_goal
      click_button "Log Out"
      visit users_url
      click_link user_in_db.email
      expect(page).to have_content "Lose 20 kg"
    end
    scenario 'allow other users to see public goals' do
      login_as(user_in_db)
      create_new_goal
      click_button "Log Out"
      login_as(user2_in_db)
      visit user_url(user_in_db)
      expect(page).to have_content "Lose 20 kg"
    end
  end

  feature 'private goals' do
    scenario 'allows users to create private goals' do
      login_as(user_in_db)
      create_new_private_goal
      expect(page).to have_selector "tr td", text: "Private"
    end

    scenario 'doesn\'t show private goals when logged out' do
      login_as(user_in_db)
      create_new_private_goal
      click_button "Log Out"
      visit user_url(user_in_db)
      expect(page).not_to have_content "Lose 20 kg"
    end

    scenario 'doesn\'t allow users to see private goals' do
      login_as(user_in_db)
      create_new_private_goal
      click_button "Log Out"
      login_as(user2_in_db)
      visit user_url(user_in_db)
      expect(page).not_to have_content "Lose 20 kg"
    end
  end

end