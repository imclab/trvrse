class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.references :location
      t.references :list
      t.text :description

      t.timestamps
    end
    add_index :list_items, :location_id
    add_index :list_items, :list_id
  end
end
