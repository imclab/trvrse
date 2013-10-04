class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.text :description
      t.references :user
      t.string :to_what
      t.string :tags

      t.timestamps
    end
    add_index :lists, :user_id
  end
end
