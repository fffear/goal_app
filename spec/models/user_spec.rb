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

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.build(:user) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest) }

    it 'should validate length of password is at least 6 characters long' do
      user_with_short_password = FactoryBot.build(:user, password: "p" * 5)
      user_with_short_password.valid?
      expect(user_with_short_password.errors.full_messages).to eq(["Password is too short (minimum is 6 characters)"])
    end

    it 'should validate uniqueness of email' do
      user_in_db = FactoryBot.create(:user, email: "test@example.com")
      user_not_in_db = FactoryBot.build(:user, email: "test@example.com")
      user_not_in_db.valid?
      expect(user_not_in_db.errors.full_messages).to eq(["Email has already been taken"])
    end

    it 'should validate uniqueness of session_token' do
      user_in_db = FactoryBot.create(:user, email: "test@example.com")
      user_not_in_db = FactoryBot.build(:user, session_token: user_in_db.session_token)
      user_not_in_db.valid?
      expect(user_not_in_db.errors.full_messages).to eq(["Session token has already been taken"])
    end
  end

  describe 'associations' do
    it { should have_many(:goals) }
  end

  describe 'class scope methods' do
    context '::find_by_credentials' do
      subject(:user) { FactoryBot.build(:user, email: "test@example.com", password: "password1")}
      before { user.save! }

      it 'should return nil if email doesn\'t exist in database' do
        expect(User.find_by_credentials("bad@email.com", "password")).to be nil
      end

      it 'should return nil if wrong password' do
        expect(User.find_by_credentials("test@example.com", "badpassword")).to be nil
      end

      it 'should return correct user when email and password are correct' do
        expect(User.find_by_credentials("test@example.com", "password1")).to eq(user)
      end
    end
  end

end
