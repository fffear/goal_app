class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      flash[:success] = "Welcome to the Goals App."
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  private
    def whitelisted_user_params
      params.require(:user).permit(:email, :password)
    end
end
