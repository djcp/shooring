module FoldersHelper

  def state_for(comment)
    content_tag(:div, :class => "states") do
      if comment.state
        previous_state = comment.previous_state
        if previous_state && comment.state != previous_state
          "#{render previous_state} &rarr; #{render comment.state}"
        else
          render(comment.state)
        end
      end
    end
  end

   def toggle_watching_button
    text = if @folder.watchers.include?(current_user)
      "Stop watching this folder"
    else
      "Watch this folder"
    end
    button_to(text, watch_activity_folder_path(@folder.activity, @folder))
  end

end
