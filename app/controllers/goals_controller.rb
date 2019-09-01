class GoalsController < ApplicationController
  before_action :requires_user!, except: :show

  def index
    @goals = current_user.goals
  end

  def new
    @goal = current_user.goals.new
  end

  def create
    @goal = current_user.goals.new(whitelisted_goal_params)

    if @goal.save
      flash[:success] = "New goal created!"
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find_by(id: params[:id])
  end

  def edit
    @goal = Goal.find_by(id: params[:id])
  end

  def update
    @goal = Goal.find_by(id: params[:id])
    if @goal.update_attributes(whitelisted_goal_params)
      flash[:success] = "Goal updated!"
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end
  
  def complete
    @goal = Goal.find_by(id: params[:id])
    @goal.completed = true
    if current_user?(@goal.user) && @goal.save
      redirect_to goal_url(@goal)
    else
      render plain: "Can't alter other user's goals", status: :forbidden
    end
  end

  def destroy
  end

  private
    def whitelisted_goal_params
      params.require(:goal).permit(:title, :private, :details, :completed)
    end
end
