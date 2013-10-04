class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.references :user
      t.integer :tripit_id
      t.string :location
      t.string :lat
      t.string :long
      t.string :name

      t.timestamps
    end
    add_index :trips, :user_id
  end
end
