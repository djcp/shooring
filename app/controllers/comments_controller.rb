class CommentsController < ApplicationController
  before_action :require_signin!
  before_filter :set_folder

  def create
    sanitize_parameters!

    #@comment = @folder.comments.build(comment_params)
    #@comment.user = current_user
    @comment = CommentWithNotifications.create(@folder.comments,
                                               current_user,
                                               comment_params)

    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to [@folder.activity, @folder]
    else
      @states = State.all
      @comment = @comment.comment
      flash[:alert] = "Comment has not been created."
      render :template => "folders/show"
    end
  end

  private
    def sanitize_parameters!
      if !current_user.admin? && cannot?(:"change states", @folder.activity)
        params[:comment].delete(:state_id)
      end

      if !current_user.admin? && cannot?(:tag, @folder.activity)
        params[:comment].delete(:tag_names)
      end
    end

    def set_folder
      @folder = Folder.find(params[:folder_id])
    end

    def comment_params
      params.require(:comment).permit(:text, :state_id, :tag_names)
    end
end
