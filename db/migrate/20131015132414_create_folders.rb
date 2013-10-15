class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :name
      t.text :description
      t.references :activity, index: true

      t.timestamps
    end
  end
end
