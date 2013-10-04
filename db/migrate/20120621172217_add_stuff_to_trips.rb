class AddStuffToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :image_url, :string
    add_column :trips, :start_date, :date
    add_column :trips, :end_date, :date
  end
end
