module GoalsFeaturesHelper
  def create_new_goal
    visit new_goal_url
    fill_in 'title', with: 'Lose 20 kg'
    fill_in 'details', with: 'Focus on dieting and exercise'
    click_on 'Create Goal'
  end

  def create_new_private_goal
    visit new_goal_url
    fill_in 'title', with: 'Lose 20 kg'
    fill_in 'details', with: 'Focus on dieting and exercise'
    choose 'goal[private]', option: true
    click_on 'Create Goal'
  end

  def edit_existing_goal(goal)
    visit edit_goal_url(goal)
    fill_in 'title', with: 'Changed Goal'
    fill_in 'details', with: 'New details'
    click_on 'Edit Goal'
  end
end