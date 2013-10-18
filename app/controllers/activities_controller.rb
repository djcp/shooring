class ActivitiesController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :require_signin!, only: [:index, :show]
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  def index
    @activities = Activity.for(current_user)
  end

  def show
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      flash[:notice] = "Activity has been created."
      redirect_to @activity
    else
      flash[:alert] = "Activity has not been created."
      render "new"
    end
  end

  def edit
  end

  def update
    if @activity.update(activity_params)
      flash[:notice] = "Activity has been updated."
      redirect_to @activity
    else
      flash[:alert] = "Activity has not been updated."
      render "edit"
    end
  end

  def destroy
    @activity.destroy

    flash[:notice] = "Activity has been deleted."
    redirect_to activities_path
  end

  private

    def activity_params
      params.require(:activity).permit(:name, :description)
    end

    def set_activity
      @activity = Activity.for(current_user).find(params[:id])
    rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The activity you were looking for could not be found."
        redirect_to activities_path
    end

end
