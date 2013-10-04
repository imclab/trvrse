class AddLocationToTrips < ActiveRecord::Migration
  def up
    change_table :trips do |t|
     t.references :location
    end
    add_index :trips, :location_id
  end
end
