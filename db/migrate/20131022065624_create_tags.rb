class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
    end

    create_table :folders_tags, id: false do |t|
      t.integer :tag_id, :folder_id
    end
  end
end
