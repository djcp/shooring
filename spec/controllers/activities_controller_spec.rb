require 'spec_helper'

describe ActivitiesController do

  it "displays an error for a missing activity" do
    get :show, id: "not-here"
    expect(response).to redirect_to(activities_path)
    message = "The activity you were looking for could not be found."
    expect(flash[:alert]).to eql(message)
  end

end
