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

class Goal < ApplicationRecord
  validates :title, presence: true
  validates :completed, :private, inclusion: { in: [false, true] }

  before_create :ensure_completed_false

  belongs_to :user

  private
    def ensure_completed_false
      self.completed = false
    end
end
