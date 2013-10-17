class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :user, index: true
      t.integer :thing_id
      t.string :thing_type
      t.string :action

      t.timestamps
    end
  end
end
