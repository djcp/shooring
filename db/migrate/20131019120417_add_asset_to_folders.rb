class AddAssetToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :asset, :string
  end
end
