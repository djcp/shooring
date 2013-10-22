class Admin::PermissionsController < Admin::BaseController
  before_action :set_user

  def index
    @ability = Ability.new(@user)
    @activities = Activity.all
  end

  def set
    @user.permissions.clear
    params[:permissions].each do |id, permissions|
      activity = Activity.find(id)
      permissions.each do |permission, checked|
        Permission.create!(user: @user,
                           thing: activity,
                           action: permission)
      end
    end
    flash[:notice] = "Permissions updated."
    redirect_to admin_user_permissions_path(@user)
  end


  private
    def set_user
      @user = User.find(params[:user_id])
    end

end
