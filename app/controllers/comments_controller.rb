class CommentsController < ApplicationController
  before_action :require_signin!
  before_filter :set_folder

  def create
    sanitize_parameters!

    @comment = @folder.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to [@folder.activity, @folder]
    else
      @states = State.all
      flash[:alert] = "Comment has not been created."
      render :template => "folders/show"
    end
  end

  private
    def sanitize_parameters!
      if cannot?("change states", @folder.activity)
        params[:comment].delete(:state_id)
      end
    end

    def set_folder
      @folder = Folder.find(params[:folder_id])
    end

    def comment_params
      params.require(:comment).permit(:text, :state_id)
    end
end
