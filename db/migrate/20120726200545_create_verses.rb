class CreateVerses < ActiveRecord::Migration
  def change
    create_table :verses do |t|
      t.references :user
      t.references :point
      t.string :caption
      t.string :tags

      t.timestamps
    end
    add_index :verses, :user_id
    add_index :verses, :point_id
  end
end
