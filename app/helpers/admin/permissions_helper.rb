module Admin::PermissionsHelper
  def permissions
    {
      "view" => "View",
      "create folders" => "Create Folders",
      "edit folders"   => "Edit Folders",
      "delete folders" => "Delete Folders",
      "change states" => "Change States"
    }
  end
end
