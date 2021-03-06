class FoldersController < ApplicationController
  before_action :require_signin!
  before_action :set_activity
  before_action :set_folder, only: [:show, :edit, :update, :destroy, :watch]
  before_action :authorize_create!, only: [:new, :create]
  before_action :authorize_update!, only: [:edit, :update]
  before_action :authorize_delete!, only: :destroy

  def show
    @comment = @folder.comments.build
    @states = State.all
  end

  def new
    @folder = @activity.folders.build
    @folder.assets.build
  end

  def create
    if cannot?(:tag, @activity)
      params[:folder].delete(:tag_names)
    end

    @folder = @activity.folders.build(folder_params)
    @folder.user = current_user

    if @folder.save
      flash[:notice] = "Folder has been created."
      redirect_to [@activity, @folder]
    else
      flash[:alert] = "Folder has not been created."
      render "new"
    end
  end

  def edit
  end

  def update
    if @folder.update(folder_params)
      flash[:notice] = "Folder has been updated."
      redirect_to [@activity, @folder]
    else
      flash[:alert] = "Folder has not been updated."
      render action: "edit"
    end
  end

  def destroy
    @folder.destroy
    flash[:notice] = "Folder has been deleted."
    redirect_to @activity
  end

  def search
    @folders = @activity.folders.search(params[:search])
    render "activities/show"
  end

  def watch
    if @folder.watchers.exists?(current_user)
      @folder.watchers -= [current_user]
      flash[:notice] = "You are no longer watching this folder."
    else
      @folder.watchers << current_user
      flash[:notice] = "You are now watching this folder."
    end

    redirect_to activity_folder_path(@folder.activity, @folder)
  end

  private
    def set_activity
      @activity = Activity.for(current_user).find(params[:activity_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The activity you were looking " +
                     "for could not be found."
      redirect_to root_path
    end

    def set_folder
       @folder = @activity.folders.find(params[:id])
    end

    def folder_params
      params.require(:folder).permit(:name, :description, :tag_names, assets_attributes: [:asset])
    end

    def authorize_create!
      if !current_user.admin? && cannot?("create folders".to_sym, @activity)
        flash[:alert] = "You cannot create folders on this activity."
        redirect_to @activity
      end
    end

    def authorize_update!
      if !current_user.admin? && cannot?("edit folders".to_sym, @activity)
        flash[:alert] = "You cannot edit folders on this activity."
        redirect_to @activity
      end
    end

    def authorize_delete!
      if !current_user.admin? && cannot?(:"delete folders", @activity)
        flash[:alert] = "You cannot delete folders from this activity."
        redirect_to @activity
      end
    end

end
