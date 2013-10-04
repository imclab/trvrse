class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.integer :id
      t.string :display_name
      t.string :city_name
      t.string :state_code
      t.string :latitude
      t.string :longitude
    end
  end
end
