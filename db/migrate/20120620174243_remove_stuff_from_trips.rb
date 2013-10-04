class RemoveStuffFromTrips < ActiveRecord::Migration
  def up
    remove_column :trips, :location
    remove_column :trips, :lat
    remove_column :trips, :long
  end

  def down
    add_column :trips, :location, :string
  end
end
