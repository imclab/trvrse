class AddLatLongToVerses < ActiveRecord::Migration
  def change
    add_column :verses, :lat, :decimal
    add_column :verses, :long, :decimal
  end
end
