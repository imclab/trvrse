class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.string :name
      t.decimal :lat
      t.decimal :long
      t.references :place

      t.timestamps
    end
    add_index :points, :place_id
  end
end
