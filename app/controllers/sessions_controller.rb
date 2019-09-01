class SessionsController < ApplicationController
  before_action :requires_user!, only: %i(destroy)
  before_action :requires_no_user!, only: %i(new create)

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      flash[:success] = "Login successful!"
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ['invalid email/password combination']
      render :new
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end
end
