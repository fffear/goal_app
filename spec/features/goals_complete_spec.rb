require 'rails_helper'
require './spec/support/auth_features_helper.rb'
require './spec/support/goals_features_helper.rb'

include AuthFeaturesHelper
include GoalsFeaturesHelper

feature 'track completed goals' do
  given!(:user_in_db) { FactoryBot.create(:user_in_db) }
  given!(:user2_in_db) { FactoryBot.create(:user2_in_db) }
  given!(:goal_of_user) { FactoryBot.create(:goal_of_user, user: user_in_db) }

  scenario 'goals start out as incomplete' do
    login_as(user_in_db)
    visit goal_url(goal_of_user)
    expect(page).to have_content "Incomplete"
  end
 
  scenario 'change status to complete on goals #show page' do
    login_as(user_in_db)
    visit goal_url(goal_of_user)
    click_on "Complete Goal #{goal_of_user.id}"
    expect(page).to have_content "Completed"
  end

  scenario 'change status to complete on goals #index page' do
    login_as(user_in_db)
    visit goals_url
    click_on "Complete Goal #{goal_of_user.id}"
    expect(page).to have_content "Completed"
  end

  scenario 'change status to complete on users #show page' do
    login_as(user_in_db)
    visit user_url(user_in_db)
    click_on "Complete Goal #{goal_of_user.id}"
    expect(page).to have_content "Completed"
  end

  scenario 'change status to complete on goals #edit page' do
    login_as(user_in_db)
    visit edit_goal_url(goal_of_user)
    check 'completed', option: true
    click_button "Edit Goal"
    expect(page).to have_content "Completed"
  end


end