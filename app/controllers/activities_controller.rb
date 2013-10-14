class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
  end

  def show
    @activity = Activity.find(params[:id])
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

  private

    def activity_params
      params.require(:activity).permit(:name, :description)
    end
end
