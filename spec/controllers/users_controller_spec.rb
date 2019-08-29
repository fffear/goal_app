require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'should render the signup page' do
      get :new, {}
      expect(response).to render_template('new')
      # expect(response).to have_http_status(200)
      assert_equal 200, response.status
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'should redirect to the #show page' do
        post :create, params: { user: { email: 'test@example.com', password: 'password1' } }
        expect(response).to redirect_to(user_url(User.last))
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid params' do
      it 'renders #new page' do
        post :create, params: { user: { email: "" } }
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end

  end
end
