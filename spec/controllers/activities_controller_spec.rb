require 'spec_helper'

describe ActivitiesController do
  let(:user) { FactoryGirl.create(:user)}

  context "standard user" do
    before do
      sign_in(user)
    end

    { new: :get,
      create: :post,
      edit: :get,
      update: :put,
      destroy: :delete }.each do |action, method|
      it "cannot access the #{action} action" do
        sign_in(user)
        send(method, action, :id => FactoryGirl.create(:activity))
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eql("You must be an admin to do that.")
      end
    end
  end

  it "displays an error for a missing activity" do
    get :show, id: "not-here"
    expect(response).to redirect_to(activities_path)
    message = "The activity you were looking for could not be found."
    expect(flash[:alert]).to eql(message)
  end

end
