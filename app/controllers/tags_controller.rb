class TagsController < ApplicationController
 def remove
    @folder = Folder.find(params[:folder_id])
    if can?(:tag, @folder.activity) || current_user.admin?
      @tag = Tag.find(params[:id])
      @folder.tags -= [@tag]
      @folder.save
    end
  end
end
