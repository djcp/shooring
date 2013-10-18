module Admin::PermissionsHelper
  def permissions
    {
      "view" => "View",
      "create folders" => "Create Folders",
      "edit folders"   => "Edit Folders",
      "delete folders" => "Delete Folders"
    }
  end
end
