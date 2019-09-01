# == Schema Information
#
# Table name: goals
#
#  id         :bigint           not null, primary key
#  completed  :boolean          default(FALSE), not null
#  details    :text
#  private    :boolean          default(FALSE), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_goals_on_title    (title)
#  index_goals_on_user_id  (user_id)
#

FactoryBot.define do
  factory :goal do
    title { Faker::Lorem.words(number:3).join(" ") }
    details { Faker::Lorem.words(number: 5).join(" ") }
    user_id { User.first.id }

    factory :goal_of_user do
      title { "Test Title 1" }
      details { "Test Details 1" }
    end
  end
end
