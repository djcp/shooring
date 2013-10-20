class CommentsController < ApplicationController
  before_action :require_signin!
  before_filter :set_folder

  def create
    @comment = @folder.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to [@folder.activity, @folder]
    else
      flash[:alert] = "Comment has not been created."
      render :template => "folders/show"
    end
  end

  private
    def set_folder
      @folder = Folder.find(params[:folder_id])
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
end
