# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email          (email) UNIQUE
#  index_users_on_session_token  (session_token) UNIQUE
#

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    
    factory :user_in_db do
      email { 'test@example.com' }
      password { 'password1' }
    end

    factory :user2_in_db do
      email { 'test2@example.com' }
      password { 'password2' }
    end
  end
end

# id        
# completed     
