class FoldersController < ApplicationController
  before_action :set_activity
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @folder = @activity.folders.build
  end


  def create
    @folder = @activity.folders.build(folder_params)
    if @folder.save
      flash[:notice] = "Folder has been created."
      redirect_to [@activity, @folder]
    else
      flash[:alert] = "Folder has not been created."
      render "new"
    end
  end

  private

    def set_activity
      @activity = Activity.find(params[:activity_id])
    end

    def set_folder
       @folder = @activity.folders.find(params[:id])
    end

    def folder_params
      params.require(:folder).permit(:name, :description)
    end
end
