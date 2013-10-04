class AddTripToVerse < ActiveRecord::Migration
  def change
    add_column :verses, :trip_id, :integer
  end
end
