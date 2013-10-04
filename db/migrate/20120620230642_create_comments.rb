class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :rating
      t.references :user
      t.references :trip
      t.text :content

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :trip_id
  end
end
