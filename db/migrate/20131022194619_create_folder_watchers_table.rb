class CreateFolderWatchersTable < ActiveRecord::Migration
  def change
    create_table :folder_watchers, id: false do |t|
      t.integer :user_id, :folder_id
    end
  end
end
