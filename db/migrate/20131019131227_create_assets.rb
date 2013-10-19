class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :asset
      t.references :folder

      t.timestamps
    end
  end
  remove_column :folders, :asset
end
