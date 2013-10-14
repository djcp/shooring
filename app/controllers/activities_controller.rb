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

  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])

    if @activity.update(activity_params)
      flash[:notice] = "Activity has been updated."
      redirect_to @activity
    else
      flash[:alert] = "Activity has not been updated."
      render "edit"
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    flash[:notice] = "Activity has been deleted."
    redirect_to activities_path
  end

  private

    def activity_params
      params.require(:activity).permit(:name, :description)
    end
end
