module AuthFeaturesHelper
  def sign_up_as(user_email)
    visit new_user_url
    fill_in 'email', with: user_email
    fill_in 'password', with: "password1"
    click_on 'Create User'
  end

  def login_as(user)
    visit new_session_url
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_on 'Login User'
  end
end