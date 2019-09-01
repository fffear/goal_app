require 'rails_helper'
require './spec/support/auth_features_helper.rb'
require './spec/support/goals_features_helper.rb'

include AuthFeaturesHelper
include GoalsFeaturesHelper

feature 'Goals CRUD' do
  given(:user_in_db) { FactoryBot.create(:user_in_db) }
  given(:goal) { FactoryBot.create(:goal, user_id: user_in_db.id) }
  background { login_as(user_in_db) }

  feature 'Creating Goals' do
    scenario 'has a goals #new page' do
      visit new_goal_url
      expect(page).to have_selector('h1', text: 'New Goal')
    end

    scenario 'Creating a goal' do
      create_new_goal
      expect(page).to have_current_path(goals_path)
      expect(page).to have_selector('h1', text: "#{user_in_db.email}'s Goals")
      expect(page).to have_content("New goal created!")
    end
  end

  feature 'Editing an existing goal' do
    scenario 'has a goal #edit page' do
      visit edit_goal_url(goal)
      expect(page).to have_selector('h1', text: 'Edit Goal')
    end

    scenario 'updating a goal' do
      edit_existing_goal(goal)
      expect(page).to have_selector('ul li', text: 'Changed Goal')
    end
  end

  scenario 'has a page showing all goals of a user' do
    visit goals_url(goal)
    expect(page).to have_selector('h1', text: "#{user_in_db.email}\'s Goals")
    expect(page).to have_selector('ul li', count: user_in_db.goals.count )
  end

  scenario 'has page showing a specific goal' do
    visit goal_url(goal)
    expect(page).to have_selector('h1', text: goal.title)
    expect(page).to have_selector('ul li', text: goal.details)
  end

  scenario 'deleting a goal' do
    visit goal_url(goal)
    click_button("Delete Goal")
    expect(page).not_to have_selector('ul li')
  end
end